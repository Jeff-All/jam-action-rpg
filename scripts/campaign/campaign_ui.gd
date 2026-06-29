class_name CampaignUI

extends MarginContainer

var campaign: Campaign

var battle_selector
var battle: BattleUI
var post_battle
var party: Party

func _ready():
	battle_selector = $BattleSelector
	battle = $Battle
	post_battle = $PostBattle
	party = $Party
	
	battle_selector.visible = false
	battle.visible = false
	post_battle.visible = false
	party.visible = false

func start(_campaign: Campaign):
	campaign = _campaign
	
	to_battle_selector()

func to_battle_selector():
	battle_selector.fill(campaign.campaign_options.battles)
	
	battle_selector.visible = true

func to_battle():
	pass

func to_post_battle():
	pass

func _battle_selector_on_party_pressed():
	party.populate(campaign)
	
	battle_selector.visible = false
	party.visible = true

func _party_on_close_pressed():
	party.visible = false
	battle_selector.visible = true

func _battle_selector_on_start_battle_pressed(battle_options: BattleOptions):
	var _battle = Battle.new()
	_battle.build(campaign, battle_options)
	
	battle.setup_battle(_battle)
	
	battle_selector.visible = false
	battle.visible = true
