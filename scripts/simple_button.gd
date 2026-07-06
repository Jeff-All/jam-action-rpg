class_name SimpleButton

extends Control

signal on_pressed(simple_button: SimpleButton)

@export var flip_h: bool

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox

@export var expand_mode: TextureRect.ExpandMode

var _texture: Texture2D = null
@onready var disabled_ui: Panel = $TextureRect/Disabled

@export var texture: Texture2D:
	set(value):
		_texture = value

var _margin: int

@export var margin: int:
	set(value):
		_margin = value

@onready var texture_rect = $TextureRect

func _ready():
	texture_rect.texture = _texture
	texture_rect.expand_mode = expand_mode
	
	disabled = false
	
	texture_rect.flip_h = flip_h

var _hover: bool = false
var _left_down: bool = false
var _disabled: bool = false

var disabled: bool:
	set(value):
		_disabled = value
		if value:
			mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
			if texture_rect.material != null:
				texture_rect.material.set_shader_parameter("index", 0)
			disabled_ui.visible = true
		else:
			mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
			disabled_ui.visible = false

func _on_mouse_entered():
	if !_disabled:
		_hover = true
		if _left_down:
			if texture_rect.material != null:
				texture_rect.material.set_shader_parameter("index", 2)
		if !_left_down:
			if texture_rect.material != null:
				texture_rect.material.set_shader_parameter("index", 1)

func _on_mouse_exited():
	if !_disabled:
		_hover = false
		if texture_rect.material != null:
			texture_rect.material.set_shader_parameter("index", 0)

func _on_gui_input(event):
	if !_disabled:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					_left_down = true
					if texture_rect.material != null:
						texture_rect.material.set_shader_parameter("index", 2)
				else:
					_left_down = false
					if _hover:
						if texture_rect.material != null:
							texture_rect.material.set_shader_parameter("index", 1)
						on_pressed.emit(self)
