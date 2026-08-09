class_name TraitDesperateDivinity

extends Trait

# When health is below trigger_health_percentage you gain a shield equal to % of the damage 
# that brought you below trigger_health_percentage and any subsequent health damage until
# you are above trigger_health_percentage

@export var buff: BuffPC
@export var trigger_health_percentage: float = 0.5
@export var base_shields: float = 1.0
@export var damage_to_shield_base_scalar: float = 0.2
@export var damage_to_shield_magic_scalar: float = 0.2
@export var damage_to_shield_strength_scalar: float = 0.2

var effect_applied: bool = false
var pcui: PCUI

func apply(_pcui: PCUI, _battle: Battle):
	pcui = _pcui
	pcui.character.on_cur_resource_change.connect(_on_character_cur_resource_change)
	pcui.on_health_damaged.connect(_on_character_take_health_damage)

func remove(_pcui: PCUI):
	pcui.character.on_cur_resource_change.disconnect(_on_character_cur_resource_change)
	pcui.on_health_damaged.disconnect(_on_character_take_health_damage)
	pcui = null

func _on_character_take_health_damage(_pc: PCUI, _attacker, damage: float):
	if !effect_applied:
		if pcui.character.resources[CharacterCampaign.Resources.HEALTH].percentage <= trigger_health_percentage:
			apply_effect()
	if effect_applied:
		var magic_scalar = pcui.character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted * damage_to_shield_magic_scalar
		var strength_scalar = pcui.character.attributes[CharacterCampaign.Attributes.STRENGTH].adjusted * damage_to_shield_strength_scalar
		var full_scalar = damage_to_shield_base_scalar + magic_scalar + strength_scalar
		var shields = base_shields + (damage * full_scalar)
		print("Desperate Divinity: Add Shield: %s = %s + %s * (%s + %s + %s)" % [shields, base_shields, damage, damage_to_shield_base_scalar, magic_scalar, strength_scalar])
		pcui.add_shield(shields)

func _on_character_cur_resource_change(resource: AdjustableResource, _change: float):
	if resource.resource == CharacterCampaign.Resources.HEALTH:
		if effect_applied && resource.percentage > trigger_health_percentage:
				remove_effect()

func apply_effect():
	effect_applied = true
	pcui.apply_buff(buff, null)

func remove_effect():
	effect_applied = false
	pcui.remove_buff(buff)
