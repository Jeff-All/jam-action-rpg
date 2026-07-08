class_name Campaign

extends Resource

var campaign_options: CampaignOptions
var party: Array[CharacterCampaign]
var gold: int
var inventory: Array[Resource]
var available_battles: Array[BattleOptions]

func _init(_campaign_options: CampaignOptions, _party: Array[CharacterCampaign]):
	campaign_options = _campaign_options
	party = _party
	
	gold = campaign_options.starting_gold
	
	for cur in campaign_options.starting_inventory:
		inventory.append(cur)
	
	for cur in campaign_options.battles:
		available_battles.append(cur)
