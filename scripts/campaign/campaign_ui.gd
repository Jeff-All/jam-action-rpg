class_name CampaignUI

extends MarginContainer

var campaign: Campaign

var battle_selector
var battle
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
	$BattleSelector.visible = true

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
