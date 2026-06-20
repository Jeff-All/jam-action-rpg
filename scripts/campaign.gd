class_name Campaign

extends MarginContainer

var campaign_options: CampaignOptions
var pcs: Array[CharacterCampaign]

var battle_selector
var battle
var post_battle
var party

func _ready():
	battle_selector = $BattleSelector
	battle = $Battle
	post_battle = $PostBattle
	party = $Party
	
	battle_selector.visible = false
	battle.visible = false
	post_battle.visible = false
	party.visible = false

func start(_campaign_options: CampaignOptions, _party: Array[CharacterCampaign]):
	campaign_options = _campaign_options
	pcs = _party
	
	to_battle_selector()

func to_battle_selector():
	$BattleSelector.visible = true

func to_battle():
	pass

func to_post_battle():
	pass
