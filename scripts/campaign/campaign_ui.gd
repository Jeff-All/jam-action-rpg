class_name CampaignUI

extends MarginContainer

signal on_exit()

var campaign: Campaign

var battle_selector: BattleSelector
var battle: BattleUI
var post_battle: PostBattle
var party: Party

var cur_battle: BattleOptions

func _ready():
	battle_selector = $BattleSelector
	battle = $Battle
	post_battle = $PostBattle
	party = $Party
	
	battle_selector.visible = false
	battle.visible = false
	post_battle.visible = false
	party.visible = false

func reset():
	battle_selector.reset()
	battle.reset()
	#post_battle.reset()
	party.reset()
	
	battle_selector.visible = false
	battle.visible = false
	party.visible = false

func start(_campaign: Campaign):
	reset()
	campaign = _campaign
	
	to_battle_selector()

func to_battle_selector():
	battle_selector.fill(campaign.available_battles.slice(0,3))
	
	battle_selector.visible = true

func to_battle():
	pass

func to_post_battle():
	post_battle.start(campaign.party)
	battle.visible = false
	post_battle.visible = true

func _battle_selector_on_party_pressed():
	party.populate(campaign)
	
	battle_selector.visible = false
	party.visible = true

func _party_on_close_pressed():
	party.visible = false
	battle_selector.visible = true

func _battle_selector_on_start_battle_pressed(battle_options: BattleOptions):
	cur_battle = battle_options
	
	var _battle = Battle.new()
	_battle.build(campaign, battle_options)
	
	battle.setup_battle(_battle)
	
	battle_selector.visible = false
	battle.visible = true

func _battle_on_exit():
	on_exit.emit()

func _battle_on_continue():
	battle.reset()
	for cur in campaign.party:
		cur.cur_xp += 5
	to_post_battle()

func _post_battle_on_end():
	campaign.available_battles.remove_at(campaign.available_battles.find(cur_battle))
	cur_battle = null
	post_battle.visible = false
	to_battle_selector()
