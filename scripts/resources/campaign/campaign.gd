class_name Campaign

extends Resource

var campaign_options: CampaignOptions
var party: Array[CharacterCampaign]
var gold: int
var inventory: Array[Resource]

var cur_tier: int = 0
var battles_this_tier: int = 0

func _init(_campaign_options: CampaignOptions, _party: Array[CharacterCampaign]):
	campaign_options = _campaign_options._duplicate()
	party = _party
	
	gold = campaign_options.starting_gold
	
	for cur in campaign_options.starting_inventory:
		inventory.append(cur)

func build():
	campaign_options.battle_builder.build()

func get_cur_battles(count: int)-> Array[BattleOptions]:
	return campaign_options.battle_builder.get_cur_battles(cur_tier, count, party.size())

func battle_complete(battle: BattleOptions):
	battles_this_tier += 1
	
	if battles_this_tier >= campaign_options.battle_builder.battles_per_tier[cur_tier]:
		battles_this_tier = 0
		cur_tier += 1
		return
	
	campaign_options.battle_builder.battle_complete(cur_tier, battle)

func get_loot(battle_options: BattleOptions) -> Array[Resource]:
	return campaign_options.loot_builder.get_loot(cur_tier, battle_options)
