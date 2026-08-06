class_name PCBuff

extends Control

signal on_duration_end(buff: PCBuff)

var animation_player: AnimationPlayer
var texture_rect: TextureRect
var stacks: Label

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
	stacks = $Stacks

func reset():
	animation_player.seek(0, true)
	stacks.visible = false

func process_animations(delta: float):
	animation_player.advance(delta)

func process_step(pc: PCUI):
	_buff.process_step(pc)

func _on_duration_end():
	on_duration_end.emit(self)

func stack_buff(caster):
	buff.add_stack()
	if buff.stacks > 1:
		print("buff_stacks: %s" % buff.stacks)
		stacks.text = "%s" % buff.stacks
		stacks.visible = true
	else: stacks.visible = false
	overwrite_buff(caster)

func overwrite_buff(caster):
	buff.caster = caster
	animation_player.stop()
	if !_buff.infinite:
		animation_player.play("Duration")

func start_buff(pc: PCUI, to_start: BuffPC, caster):
	stacks.visible = false
	buff = to_start.duplicate()
	buff.caster = caster
	buff.apply(pc)
	if buff.stacks > 1:
		print("buff_stacks: %s" % buff.stacks)
		stacks.text = "%s" % buff.stacks
		stacks.visible = true
	else: stacks.visible = false
	if !_buff.infinite:
		animation_player.speed_scale = 1.0 / _buff.get_duration(pc)
		animation_player.play("Duration")
	else: animation_player.stop()
	visible = true
