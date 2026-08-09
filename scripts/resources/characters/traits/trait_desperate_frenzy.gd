class_name TraitDesperateFrenzy

extends Trait

@export var buff: BuffPC
@export var trigger_health_percentage: float = 0.5
@export var speed_scale: float = 1.0

var effect_applied: bool = false
var pcui: PCUI

func apply(_pcui: PCUI, _battle: Battle):
	pcui = _pcui
	pcui.character.on_cur_resource_change.connect(_on_character_cur_resource_change)

func remove(_pcui: PCUI):
	pcui.character.on_cur_resource_change.disconnect(_on_character_cur_resource_change)
	pcui = null

func _on_character_cur_resource_change(resource: AdjustableResource, _change: float):
	if resource.resource == CharacterCampaign.Resources.HEALTH:
		if !effect_applied:
			if resource.percentage <= trigger_health_percentage:
				apply_effect()
		else:
			if resource.percentage > trigger_health_percentage:
				remove_effect()

func apply_effect():
	effect_applied = true
	for cur in pcui.abilities:
		if cur.ability is AbilityAttack:
			cur.speed_scale.add_adjustment(buff, speed_scale)
	pcui.apply_buff(buff, null)

func remove_effect():
	effect_applied = false
	for cur in pcui.abilities:
		if cur.ability is AbilityAttack:
			cur.speed_scale.remove_adjustment(buff)
	pcui.remove_buff(buff)
