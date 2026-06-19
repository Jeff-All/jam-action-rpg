class_name AbilityBattle

extends Resource

var ability_campaign: AbilityCampaign
var character: Character

var buffs: Dictionary[String, BuffState]

var _cur_cooldown: float = 0.0

signal on_update_cooldown(percent: float)

func _init(_ability_campaign: AbilityCampaign, _character: Character):
	ability_campaign = _ability_campaign
	character = _character

func start_cooldown():
	_cur_cooldown = ability_campaign.base.get_cooldown(character)

func update_cooldowns(delta: float, char_cooldown_percent: float, char_cooldown_cur: float, attack_cooldown_percent: float, attack_cooldown_cur: float):
	_cur_cooldown = maxf(0.0, _cur_cooldown - delta)
	var percent = _cur_cooldown / ability_campaign.base.get_cooldown(character)
	var min_cooldown = _cur_cooldown
	
	if min_cooldown < char_cooldown_cur:
		percent = char_cooldown_percent
		min_cooldown = char_cooldown_cur
	
	#if base is AttackAction && min_cooldown < attack_cooldown_cur:
	#	percent = attack_cooldown_percent
	
	on_update_cooldown.emit(percent)
