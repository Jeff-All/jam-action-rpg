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
			texture_rect.material.set_shader_parameter("index", 0)
			#_panel.add_theme_stylebox_override("panel", default_color)
			disabled_ui.visible = true
		else:
			mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
			disabled_ui.visible = false

func _on_mouse_entered():
	if !_disabled:
		_hover = true
		if _left_down:
			texture_rect.material.set_shader_parameter("index", 2)
			#_panel.add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			texture_rect.material.set_shader_parameter("index", 1)
			#_panel.add_theme_stylebox_override("panel", hover_color)

func _on_mouse_exited():
	if !_disabled:
		_hover = false
		texture_rect.material.set_shader_parameter("index", 0)
		#_panel.add_theme_stylebox_override("panel", default_color)

func _on_gui_input(event):
	if !_disabled:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					_left_down = true
					texture_rect.material.set_shader_parameter("index", 2)
					#_panel.add_theme_stylebox_override("panel", down_color)
				else:
					_left_down = false
					if _hover:
						texture_rect.material.set_shader_parameter("index", 1)
						#_panel.add_theme_stylebox_override("panel", hover_color)
						on_pressed.emit(self)
