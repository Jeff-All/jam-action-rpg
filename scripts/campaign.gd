class_name Campaign

extends MarginContainer

var campaign_options: CampaignOptions
var party: Array[CharacterCampaign]

var battle_selector
var battle
var post_battle

func _ready():
	battle_selector = $BattleSelector
	battle = $Battle
	post_battle = $PostBattle
	
	battle_selector.visible = false
	battle.visible = false
	post_battle.visible = false

func start(_campaign_options: CampaignOptions, _party: Array[CharacterCampaign]):
	campaign_options = _campaign_options
	party = _party

func to_battle_selector():
	pass

func to_battle():
	pass

func to_post_battle():
	pass
