class_name SimpleButton

extends Control

signal on_pressed(simple_button: SimpleButton)

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox

@export var expand_mode: TextureRect.ExpandMode

var _texture: Texture2D = null
var _panel: Panel

@export var texture: Texture2D:
	set(value):
		_texture = value

var _margin: int

@export var margin: int:
	set(value):
		_margin = value

@onready var texture_rect = $MarginContainer/PanelContainer/MarginContainer/TextureRect

func _ready():
	print("margin: %s" % margin)
	texture_rect.texture = _texture
	texture_rect.expand_mode = expand_mode
	_panel = $Panel
	
	$MarginContainer/PanelContainer/MarginContainer.add_theme_constant_override("margin_top", _margin)
	$MarginContainer/PanelContainer/MarginContainer.add_theme_constant_override("margin_left", _margin)
	$MarginContainer/PanelContainer/MarginContainer.add_theme_constant_override("margin_bottom", _margin)
	$MarginContainer/PanelContainer/MarginContainer.add_theme_constant_override("margin_right", _margin)

var _hover: bool = false
var _left_down: bool = false
var _disabled: bool = false

var disabled: bool:
	set(value):
		_disabled = value
		if value:
			mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
			$Disabled.visible = true
			_panel.add_theme_stylebox_override("panel", default_color)
		else:
			mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
			$Disabled.visible = false

func _on_mouse_entered():
	print("mouse_entered")
	if !_disabled:
		_hover = true
		if _left_down:
			_panel.add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			_panel.add_theme_stylebox_override("panel", hover_color)

func _on_mouse_exited():
	if !_disabled:
		_hover = false
		_panel.add_theme_stylebox_override("panel", default_color)

func _on_gui_input(event):
	if !_disabled:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					_left_down = true
					_panel.add_theme_stylebox_override("panel", down_color)
				else:
					_left_down = false
					if _hover: 
						_panel.add_theme_stylebox_override("panel", hover_color)
						on_pressed.emit(self)
