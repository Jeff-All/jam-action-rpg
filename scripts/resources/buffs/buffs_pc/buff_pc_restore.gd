class_name BuffPCRestore

extends BuffPC

@export var healing_per_step: int

var step_count: int = 0
var total_heal: float = 0


func apply(pc: PCUI):
	super(pc)
	total_heal = get_duration(pc) * healing_per_step

func get_duration(_caster) -> float:
	return duration + caster._character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted

func process_step(pc: PCUI):
	step_count += 1
	if step_count % int(1 / Global.step_size) == 0:
		var healed = pc._character.heal(healing_per_step)
		pc.emit_global_threat.emit(caster, healed - (caster._character.attributes[CharacterCampaign.Attributes.SUBTLETY].adjusted * healing_per_step / total_heal))
		pc.spawn_combat_text("+%s" % (healed as int))
