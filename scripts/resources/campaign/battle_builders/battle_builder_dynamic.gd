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
	var actions: int = 0
	var remaining: int = pc_count + cr
	var slots = 7 - remaining
	var allocations: Dictionary[int, int] = { -2:0, -1:0, 0:0, 1:0, 2:0 }
	if remaining >= 4 && tier < enemies.size() - 2:
		if randi_range(0, 1) == 0: 
			var num = randi_range(1, floori(remaining / 4.0))
			allocations[2] = num
			remaining -= (num * 4)
			slots += (num * 3)
			actions -= (num * 3)
	if remaining >= 2 && tier < enemies.size() - 1:
		if randi_range(0, 1) == 0:
			var num = randi_range(1, floori(remaining / 2.0))
			allocations[1] = num
			remaining -= (num * 2)
			slots += num
			actions -= num
	if remaining >= 1 && slots > 1 && tier > 0:
		if randi_range(0, 3) == 0:
			var roll1 = randi_range(1, min(remaining, slots))
			slots -= roll1
			var roll2 = 0
			if tier > 1:
				roll2 = randi_range(0, min(roll1, slots))
				allocations[-2] = roll2 * 4
				actions += (roll2 * 3)
			actions += roll1 - roll2
			allocations[-1] = (roll1 - roll2) * 2
			
	if remaining >= 1:
		allocations[0] = remaining
	
	if actions > 0:
		downgrade_actions(tier, actions, allocations)
	else: if actions < 0:
		upgrade_actions(tier, actions, allocations)
	
	return allocations

func downgrade_actions(tier: int, actions: int, allocations: Dictionary[int, int]) -> Dictionary[int, int]:
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
	var keys: Array[int] = allocations.keys()
	keys.sort()
	
	var index = max(1, 3 - tier)
	
	while actions < 0 && index < keys.size() - max(1, (tier + 1) - enemies.size()):
		var upgraded = min(actions * -1, allocations[keys[index]])
		actions += upgraded
		allocations[keys[index]] -= upgraded
		allocations[keys[index + 1]] += upgraded
		index += 1
	return allocations

func generate_battle_profile(allocations: Dictionary[int, int]) -> Array:
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
	var options: BattleOptions = BattleOptions.new()
	
	for cur in profile[0]:
		options.front_row.append(enemies[cur + tier])
	for cur in profile[1]:
		options.back_row.append(enemies[cur + tier])
	
	return options

func get_cur_battles(cur_tier: int, count: int, pc_count: int)-> Array[BattleOptions]:
	var battles: Array[BattleOptions] = []
	var crs = generate_crs()
	for cur in crs:
		battles.append(generate_battle_options(cur_tier, generate_battle_profile(generate_battle_allocations(cur_tier, pc_count, cur))))
	
	return battles

func battle_complete(cur_tier: int, battle: BattleOptions):
	pass
