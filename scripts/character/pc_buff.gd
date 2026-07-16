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
	get:
		return _buff

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

func start_buff(pc: PCUI, to_start: BuffPC, caster):
	buff = to_start.duplicate()
	buff.caster = caster
	buff.apply(pc)
	animation_player.speed_scale = 1.0 / _buff.get_duration(pc)
	animation_player.play("Duration")
	visible = true
