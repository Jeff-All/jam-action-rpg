class_name CombatTextInstance

extends Label

var distance: float = 100
@export var progress: float:
	set(value):
		position.y = start - (value * distance)
var start: float

signal on_animation_end(combat_text: CombatTextInstance)

func _ready():
	print("ready")

func start_animation(pos: Vector2, _text: String):
	text = _text
	position.x = 0
	set_position(pos - (size / 2) )
	start = position.y
	visible = true
	$AnimationPlayer.play("float")

func _on_animation_end():
	visible = false
	on_animation_end.emit(self)
