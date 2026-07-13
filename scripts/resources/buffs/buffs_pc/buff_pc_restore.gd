class_name BuffPCRestore

extends BuffPC

@export var healing_per_step: int

var step_count: int = 0

func get_duration(caster) -> float:
	return duration + caster._character.character_campaign.attributes[CharacterCampaign.Attributes.MAGIC]

func process_step(pc: PCUI):
	step_count += 1
	if step_count % int(1 / Global.step_size) == 0:
		pc._character.add_cur_resource(CharacterCampaign.Resources.HEALTH, healing_per_step)
		pc.spawn_combat_text("+%s" % healing_per_step)
