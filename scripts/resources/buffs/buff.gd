class_name Buff

extends Resource

@export var name: String
@export var texture: Texture2D
@export var base_duration: float

signal on_apply(active: BuffActive)
signal on_tick(active: BuffActive)
signal on_end(active: BuffActive)
signal on_removal(active: BuffActive)

func new_active(state: BuffState, caster: Character, target: Character) -> BuffActive:
	var active = BuffActive.new(state, caster, target)
	active.variables["initial_duration"] = base_duration
	active.variables["remaining_duration"] = base_duration
	return active

func apply(active: BuffActive, _caster: Character, _target: Character):
	on_apply.emit(active)

func tick(active: BuffActive, _caster: Character, _target: Character) -> bool:
	active.variables["remaining_duration"] -= 1
	on_tick.emit(active)
	return active.variables["remaining_duration"] > 0

func end(active: BuffActive, _caster: Character, _target: Character):
	on_end.emit(active)

func removal(active: BuffActive, _caster: Character, _target: Character):
	on_removal.emit(active)
