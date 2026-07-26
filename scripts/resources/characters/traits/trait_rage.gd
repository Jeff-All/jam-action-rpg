class_name TraitRage

extends Trait

@export var rage_per_damage: float

var pcui: PCUI

func apply(_pcui: PCUI):
	pcui = _pcui
	pcui._character.on_cur_resource_change.connect(_on_character_cur_resource_change)

func remove(_pcui: PCUI):
	pcui._character.on_cur_resource_change.disconnect(_on_character_cur_resource_change)
	pcui = null

func _on_character_cur_resource_change(resource: AdjustableResource, change: float):
	if resource.resource == CharacterCampaign.Resources.HEALTH && change < 0:
		pcui._character.resources[CharacterCampaign.Resources.STAMINA].cur += rage_per_damage * change * -1
