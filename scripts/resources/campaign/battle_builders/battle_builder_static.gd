class_name BattleBuilderStatic

extends BattleBuilder

@export var tiers: Array[BattleBuilderStaticTier]

func build():
	super()
	populate_tiers()

func populate_tiers():
	for cur in range(0, min(tiers.size(), battles_per_tier.size())):
		populate_tier(cur, battles_per_tier[cur])

func populate_tier(tier: int, cur_tier_count: int):
	if tier == 0: 
		cur_tier_count += 1
	else: 
		tiers[tier]._prev_battle = get_random_battle_from_tier_and_remove(tier - 1)
	if tier >= tiers.size() - 1:
		cur_tier_count += 1
	else:
		tiers[tier]._next_battle = get_random_battle_from_tier_and_remove(tier + 1)
	assert(cur_tier_count <= tiers[tier].battles.size(), "Not enough battles in tier %s, needed %s found %s" % [tier, cur_tier_count, tiers[tier].battles.size()])
	for cur in range(0, cur_tier_count):
		tiers[tier]._battles.append(get_random_battle_from_tier_and_remove(tier))

func get_random_battle_from_tier_and_remove(tier: int) -> BattleOptions:
	var random_int = randi_range(0, tiers[tier].battles.size() - 1)
	var battle = tiers[tier].battles[random_int]
	tiers[tier].battles.remove_at(random_int)
	return battle

func get_cur_battles(cur_tier: int, count: int, pc_count: int)-> Array[BattleOptions]:
	var _available_battles: Array[BattleOptions] = []
	
	for cur in tiers[cur_tier]._battles:
		_available_battles.append(cur)
	
	if tiers[cur_tier]._next_battle != null:
		_available_battles.append(tiers[cur_tier]._next_battle)
	
	if tiers[cur_tier]._prev_battle != null:
		_available_battles.push_front(tiers[cur_tier]._prev_battle)
	
	var battles: Array[BattleOptions] = []
	for cur in range(0, count):
		var rand_int = randi_range(0, _available_battles.size() - 1)
		battles.append(_available_battles[rand_int])
		_available_battles.remove_at(rand_int)
	
	return battles

func battle_complete(cur_tier: int, battle: BattleOptions):
	if battle == tiers[cur_tier]._next_battle:
		tiers[cur_tier]._next_battle = null
	else: if battle == tiers[cur_tier]._prev_battle:
		tiers[cur_tier]._prev_battle = null
	else:
		tiers[cur_tier]._battles.remove_at(tiers[cur_tier]._battles.find(battle))
