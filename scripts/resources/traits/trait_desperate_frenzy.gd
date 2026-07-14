class_name TraitDesperateFrenzy

extends Trait

@export var buff: BuffPCDesperateFury
@export var trigger_health_percentage: float = 0.5

var effect_applied: bool = false
var pcui: PCUI

func apply(_pcui: PCUI):
	pcui = _pcui
	pcui._character.on_cur_resource_change.connect(_on_character_cur_resource_change)

func remove(_pcui: PCUI):
	pcui._character.on_cur_resource_change.disconnect(_on_character_cur_resource_change)
	pcui = null

func _on_character_cur_resource_change(resource: AdjustableResource, _change: float):
	if resource.resource == CharacterCampaign.Resources.HEALTH:
		if !effect_applied:
			if resource.percentage < trigger_health_percentage:
				apply_effect()

func apply_effect():
	effect_applied = true
	pcui.apply_buff(buff)
