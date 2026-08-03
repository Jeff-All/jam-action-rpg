class_name Buff

extends Resource

@export var name: String
@export var texture: Texture2D
@export var duration: float
@export var stackable: bool

var stacks: int = 0

func get_duration(caster) -> float:
	return duration

func add_stack():
	pass

func remove_stack():
	pass
