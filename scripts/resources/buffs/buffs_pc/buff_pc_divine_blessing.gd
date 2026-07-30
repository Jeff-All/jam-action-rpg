class_name BuffPCDivineBlessing

extends BuffPC

@export var shielding_per_step: int = 1
@export var seconds_per_application: float = 3.0 
@export var base_applications: int = 0

var step_count: int = 0
var _shielding_per_step: float

func apply(pc: PCUI):
	super(pc)
	
	if pc != caster:
		var cur_shield = caster._character.resources[CharacterCampaign.Resources.SHIELDING].cur
		_shielding_per_step = shielding_per_step + (cur_shield / (caster._character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted + base_applications))
		caster._character.resources[CharacterCampaign.Resources.SHIELDING].cur = 0
	else: _shielding_per_step = shielding_per_step

func get_duration(_caster) -> float:
	return (caster._character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted + base_applications) * seconds_per_application

func process_step(pc: PCUI):
	step_count += 1
	if step_count % int(seconds_per_application / Global.step_size) == 0:
		pc.add_shield(_shielding_per_step)
