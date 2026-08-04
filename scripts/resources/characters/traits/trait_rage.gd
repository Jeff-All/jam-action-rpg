class_name TraitRage

extends Trait

@export var rage_per_damage: float

var pcui: PCUI

func apply(_pcui: PCUI, _battle: Battle):
	pcui = _pcui
	pcui.character.on_cur_resource_change.connect(_on_character_cur_resource_change)

func remove(_pcui: PCUI):
	pcui.character.on_cur_resource_change.disconnect(_on_character_cur_resource_change)
	pcui = null

func _on_character_cur_resource_change(resource: AdjustableResource, change: float):
	if resource.resource == CharacterCampaign.Resources.HEALTH && change < 0:
		pcui.character.resources[CharacterCampaign.Resources.STAMINA].cur += rage_per_damage * change * -1
