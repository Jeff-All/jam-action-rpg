class_name AbilityBattle

extends Resource

var ability_campaign: AbilityCampaign
var character: CharacterBattle

var _cur_cooldown: float = 0.0

signal on_update_cooldown(percent: float)

func _init(_ability_campaign: AbilityCampaign, _character: CharacterBattle):
	ability_campaign = _ability_campaign
	character = _character

func start_cooldown():
	pass

func update_cooldowns(delta: float, char_cooldown_percent: float, char_cooldown_cur: float, attack_cooldown_percent: float, attack_cooldown_cur: float):
	pass
