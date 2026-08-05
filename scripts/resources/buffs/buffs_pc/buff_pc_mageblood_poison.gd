class_name BuffPCMagebloodPoison

extends BuffPC

@export var damage: int = 1

func apply(pc: PCUI):
	pc.on_resources_consumed.connect(_on_target_resources_consumed)

func remove(pc: PCUI):
	pc.on_resources_consumed.disconnect(_on_target_resources_consumed)

func _on_target_resources_consumed(pcui: PCUI, cost: Dictionary[CharacterCampaign.Resources, int]):
	if cost.has(CharacterCampaign.Resources.MANA):
		pcui.take_damage(null, damage, true)
