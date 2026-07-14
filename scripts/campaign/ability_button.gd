class_name AbilityButton

extends PanelContainer

signal on_pressed(AbilityButton)

@export var grayout_theme: StyleBoxFlat
@export var cant_afford_theme: StyleBoxFlat

var sub_view_port_container: SubViewportContainer
var animation_player: AnimationPlayer
var grayout: Panel
var texture_rect: TextureRect
var _material: ShaderMaterial

var _can_afford: bool = true
var on_cooldown: bool = false

var _clickable: bool = true
var _hover: bool = false
var _left_down: bool = false
var _selected: bool = false

var speed_scale: AdjustableAttribute = AdjustableAttribute.new()

var _ability: Ability

var ability: Ability:
	set(value):
		_ability = value
		if _ability != null:
			texture_rect.texture = _ability.texture
	get:
		return _ability

var clickable: bool:
	set(value):
		_clickable = value
		if _clickable:
			if _hover:
				_material.set_shader_parameter("index", 2)
			else:
				_material.set_shader_parameter("index", 1)
			if !on_cooldown:
				mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
			else:
				mouse_default_cursor_shape = Control.CursorShape.CURSOR_ARROW
		else:
			_material.set_shader_parameter("index", 0)
			mouse_default_cursor_shape = Control.CursorShape.CURSOR_ARROW
	get:
		return !on_cooldown && _clickable && can_afford

var selected: bool:
	set(value):
		_selected = value
		if _selected:
			_material.set_shader_parameter("index", 4)
			mouse_default_cursor_shape = Control.CursorShape.CURSOR_ARROW
		else:
			if clickable:
				if _hover:
					_material.set_shader_parameter("index", 2)
				else:
					_material.set_shader_parameter("index", 1)
					mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
			else:
				_material.set_shader_parameter("index", 0)
				mouse_default_cursor_shape = Control.CursorShape.CURSOR_ARROW

var can_afford: bool:
	set(value):
		if _can_afford != value:
			if value:
				_on_can_afford()
			else:
				_on_cant_afford()
		_can_afford = value
	get: return _can_afford

func _ready():
	sub_view_port_container = $SubViewportContainer
	
	animation_player = $AnimationPlayer
	grayout = $SubViewportContainer/SubViewport/TextureRect/MarginContainer/VBoxContainer/Grayout/Panel4
	texture_rect = $SubViewportContainer/SubViewport/TextureRect
	
	_material = $SubViewportContainer.material
	
	grayout.add_theme_stylebox_override("panel", grayout_theme)
	
	speed_scale.base = 1.0

func reset():
	clickable = true
	_hover = false
	_left_down = false
	_selected = false
	
	can_afford = true
	on_cooldown = false
	
	speed_scale.reset()
	
	animation_player.play("RESET")
	animation_player.advance(1)

func process_animations(delta: float):
	animation_player.advance(delta * speed_scale.adjusted)

func process_step():
	pass

func _on_mouse_entered():
	_hover = true
	if clickable && !_selected:
		_material.set_shader_parameter("index", 2)

func _on_mouse_exited():
	_hover = false
	if !_selected:
		if clickable:
			_material.set_shader_parameter("index", 1)
		else:
			_material.set_shader_parameter("index", 0)

func _on_gui_input(event):
	if clickable && !_selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					_left_down = true
					_material.set_shader_parameter("index", 3)
				else:
					_left_down = false
					if _hover:
						_material.set_shader_parameter("index", 2)
						on_pressed.emit(self)

func _on_cooldown_started(duration: float):
	on_cooldown = true
	animation_player.stop()
	animation_player.speed_scale = 1/duration
	animation_player.current_animation = "ability_cooldown"
	mouse_default_cursor_shape = Control.CursorShape.CURSOR_ARROW

func _on_cooldown_animation_ended():
	on_cooldown = false
	animation_player.speed_scale = 1
	if can_afford:
		animation_player.play("ability_flash")
		mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
		if _hover:
			_material.set_shader_parameter("index", 2)
	else:
		animation_player.play("ability_pre_flash")

func _on_flash_animation_ended():
	if can_afford:
		grayout.add_theme_stylebox_override("panel", grayout_theme)

func _on_cant_afford():
	grayout.add_theme_stylebox_override("panel", cant_afford_theme)
	if !on_cooldown:
		animation_player.stop()
		animation_player.play("ability_pre_flash")

func _on_can_afford():
	if !on_cooldown:
		animation_player.stop()
		animation_player.play("ability_flash")
		mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
	grayout.add_theme_stylebox_override("panel", grayout_theme)

func start_cooldown(duration: float):
	if on_cooldown:
		if get_remaining_cooldown() >= duration:
			return
	_on_cooldown_started(duration)

func get_remaining_cooldown() -> float:
	return (animation_player.current_animation_length - animation_player.current_animation_position) / abs(animation_player.speed_scale)
