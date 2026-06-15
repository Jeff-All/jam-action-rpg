class_name BuffRestore

extends Buff

@export var heal_per_tick: int = 1

func new_active(state: BuffState, caster: Character, target: Character) -> BuffActive:
	var active = super(state, caster, target)
	active.variables["initial_duration"] = base_duration + caster.magic
	active.variables["remaining_duration"] = base_duration + caster.magic
	active.variables["heal_per_tick"] = heal_per_tick
	return active

func tick(active: BuffActive, caster: Character, target: Character) -> bool:
	target.heal(heal_per_tick)
	return super(active, caster, target)
