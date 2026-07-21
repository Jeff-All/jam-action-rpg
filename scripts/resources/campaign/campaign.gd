class_name Campaign

extends Resource

var campaign_options: CampaignOptions
var party: Array[CharacterCampaign]
var gold: int
var inventory: Array[Resource]
var available_battles: Array[BattleOptions]

var cur_tier: int = 0
var battles_this_tier: int = 0

func _init(_campaign_options: CampaignOptions, _party: Array[CharacterCampaign]):
	campaign_options = _campaign_options._duplicate()
	party = _party
	
	gold = campaign_options.starting_gold
	
	for cur in campaign_options.starting_inventory:
		inventory.append(cur)
	
	for cur in campaign_options.battles:
		available_battles.append(cur)

func populate_tiers():
	for cur in range(0, campaign_options.tiers.size()):
		populate_tier(cur)

func populate_tier(tier: int):
	var cur_tier_count = campaign_options.tiers[tier].battles_to_next
	if tier == 0: 
		cur_tier_count += 1
	else: 
		campaign_options.tiers[tier]._prev_battle = get_random_battle_from_tier_and_remove(tier - 1)
	if tier >= campaign_options.tiers.size() - 1:
		cur_tier_count += 1
	else:
		campaign_options.tiers[tier]._next_battle = get_random_battle_from_tier_and_remove(tier + 1)
	assert(cur_tier_count <= campaign_options.tiers[tier].battles.size(), "Not enough battles in tier %s, needed %s found %s" % [tier, cur_tier_count, campaign_options.tiers[tier].battles.size()])
	for cur in range(0, cur_tier_count):
		campaign_options.tiers[tier]._battles.append(get_random_battle_from_tier_and_remove(tier))

func get_random_battle_from_tier_and_remove(tier: int) -> BattleOptions:
	var random_int = randi_range(0, campaign_options.tiers[tier].battles.size() - 1)
	var battle = campaign_options.tiers[tier].battles[random_int]
	campaign_options.tiers[tier].battles.remove_at(random_int)
	return battle

func get_cur_battles(count: int)-> Array[BattleOptions]:
	var _available_battles: Array[BattleOptions] = []
	
	for cur in campaign_options.tiers[cur_tier]._battles:
		_available_battles.append(cur)
	
	if campaign_options.tiers[cur_tier]._next_battle != null:
		_available_battles.append(campaign_options.tiers[cur_tier]._next_battle)
	
	if campaign_options.tiers[cur_tier]._prev_battle != null:
		_available_battles.push_front(campaign_options.tiers[cur_tier]._prev_battle)
	
	var battles: Array[BattleOptions] = []
	for cur in range(0, count):
		var rand_int = randi_range(0, _available_battles.size() - 1)
		battles.append(_available_battles[rand_int])
		_available_battles.remove_at(rand_int)
	
	return battles

func battle_complete(battle: BattleOptions):
	battles_this_tier += 1
	
	if battles_this_tier >= campaign_options.tiers[cur_tier].battles_to_next:
		battles_this_tier = 0
		cur_tier += 1
		return
	
	if battle == campaign_options.tiers[cur_tier]._next_battle:
		campaign_options.tiers[cur_tier]._next_battle = null
	else: if battle == campaign_options.tiers[cur_tier]._prev_battle:
		campaign_options.tiers[cur_tier]._prev_battle = null
	else:
		campaign_options.tiers[cur_tier]._battles.remove_at(campaign_options.tiers[cur_tier]._battles.find(battle))
