class_name Buff

extends Resource

@export var name: String
@export var texture: Texture2D
@export var duration: float
@export var stackable: bool

func get_duration(caster) -> float:
	return duration
