class_name PCBuff

extends Control

signal on_duration_end(buff: PCBuff)

var animation_player: AnimationPlayer
var texture_rect: TextureRect

var _buff: BuffPC

var buff: BuffPC:
	set(value):
		_buff = value
		if _buff != null:
			texture_rect.texture = _buff.texture

func _ready():
	texture_rect = $SubViewportContainer/SubViewport/TextureRect
	animation_player = $AnimationPlayer

func reset():
	animation_player.seek(0, true)

func process_animations(delta: float):
	animation_player.advance(delta)

func process_step(pc: PCUI):
	_buff.process_step(pc)

func _on_duration_end():
	on_duration_end.emit(self)

func start_buff(pc: PCUI, to_start: BuffPC):
	buff = to_start.duplicate()
	animation_player.play("Duration", -1, 1.0 / _buff.get_duration(pc))
	visible = true
