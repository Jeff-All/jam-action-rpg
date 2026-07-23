class_name BattleBuilderDynamic

extends BattleBuilder

@export var enemies: Dictionary[int, Enemy]

func build():
	pass

func generate_crs() -> Array[int]:
	var to_return: Array[int] = [0, 0, 1, 2, 3]
	to_return.remove_at(randi_range(1,4))
	to_return.remove_at(randi_range(1,3))
	return to_return

func generate_battle_allocations(tier: int, pc_count: int, cr: int) -> Dictionary[int, int]:
	print("generate_battle_allocations(tier=%s, pc_count=%s, cr=%s)" % [tier, pc_count, cr])
	var actions: int = pc_count * -1
	var remaining: int = pc_count + cr
	var slots = 7
	var allocations: Dictionary[int, int] = { -2:0, -1:0, 0:0, 1:0, 2:0 }
	if remaining >= 4 && tier < enemies.size() - 2:
		if randi_range(0, 1) == 0: 
			var num = randi_range(1, min(slots, floori(remaining / 4.0)))
			allocations[2] = num
			remaining -= (num * 4)
			slots -= num
			actions += num
			print("+2: %s" % num)
	if remaining >= 2 && tier < enemies.size() - 1:
		if randi_range(0, 1) == 0:
			var num = randi_range(1, min(slots, floori(remaining / 2.0)))
			allocations[1] = num
			remaining -= (num * 2)
			slots -= num
			actions += num
			print("+1: %s" % num)
	if remaining >= 1 && slots > 1 && tier > 0:
		if randi_range(0, 3) == 0:
			var roll1 = randi_range(1, min(remaining, slots))
			slots -= roll1
			var roll2 = 0
			if tier > 1:
				roll2 = randi_range(0, min(roll1, slots))
				allocations[-2] = roll2 * 4
				actions += (roll2 * 4)
				remaining -= roll2
				print("-2: %s" % roll2)
			actions += ((roll1 - roll2) * 2)
			allocations[-1] = (roll1 - roll2) * 2
			remaining -= (roll1 - roll2)
			print("-1: %s" % ((roll1 - roll2) * 2))
			
	if remaining >= 1:
		var left = min(slots, remaining)
		actions += left
		allocations[0] = left
		remaining -= left
		print("0: %s" % left)
	
	print("remaining: %s" % remaining)
	print("actions: %s" % actions)
	
	actions -= remaining
	
	if actions > 0:
		downgrade_actions(tier, actions, allocations)                                                                        
	else: if actions < 0:
		upgrade_actions(tier, actions, allocations)
	
	return allocations

func downgrade_actions(tier: int, actions: int, allocations: Dictionary[int, int]) -> Dictionary[int, int]:
	print("downgrade_actions: %s" % allocations)
	var keys: Array[int] = allocations.keys()
	keys.sort()
	
	var index = max(1, 3 - tier)
	
	while actions > 0 && index < keys.size():
		var downgraded = min(actions, allocations[keys[index]])
		actions -= downgraded
		allocations[keys[index]] -= downgraded
		allocations[keys[index - 1]] += downgraded
		index += 1
	
	return allocations

func upgrade_actions(tier: int, actions: int, allocations: Dictionary[int, int]):
	print("upgrade_actions(%s): %s" % [actions, allocations])
	var keys: Array[int] = allocations.keys()
	keys.sort()
	
	var index = max(1, 2 - tier)
	
	while actions < 0 && index < keys.size() - 1:
		var upgraded = min(actions * -1, allocations[keys[index]])
		print("upgraded[%s] %s" %[keys[index], upgraded])
		actions += upgraded
		allocations[keys[index]] -= upgraded
		allocations[keys[index + 1]] += upgraded
		index += 1
	
	if actions < 0:
		print("add enemies: %s" % actions)
		allocations[keys[max(0, 2 - tier)]] -= actions
	
	return allocations

func generate_battle_profile(allocations: Dictionary[int, int]) -> Array:
	print("generate_battle_profile(%s)" % allocations)
	var sorted_allocations = allocations.keys()
	sorted_allocations.sort()
	sorted_allocations.reverse()
	
	var front: Array[int] = []
	var back: Array[int] = []
	
	for tier in sorted_allocations:
		for c in range(0, allocations[tier]):
			var roll = randi_range(0, 7 - back.size() - front.size())
			if roll < 4 - front.size():
				if front.size() % 2 == 0:
					front.append(tier)
				else:
					front.push_front(tier)
			else:
				if back.size() % 2 == 0:
					back.append(tier)
				else:
					back.push_front(tier)
	
	return [front, back]

func generate_battle_options(tier: int, profile: Array) -> BattleOptions:
	print("generate_battle_options(%s)" % [profile])
	var options: BattleOptions = BattleOptions.new()
	
	for cur in profile[0]:
		options.front_row.append(enemies[cur + tier])
	for cur in profile[1]:
		options.back_row.append(enemies[cur + tier])
	
	return options

func get_cur_battles(cur_tier: int, count: int, pc_count: int)-> Array[BattleOptions]:
	print()
	print("get_cur_battles: %s" % cur_tier)
	var battles: Array[BattleOptions] = []
	var crs = generate_crs()
	for cur in crs:
		var options = generate_battle_options(cur_tier, generate_battle_profile(generate_battle_allocations(cur_tier, pc_count, cur)))
		options.difficulty = cur
		battles.append(options)
		print()
	
	return battles

func battle_complete(cur_tier: int, battle: BattleOptions):
	pass
