class_name SimpleButton

extends PanelContainer

signal on_pressed(simple_button: SimpleButton)

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox

var _texture: Texture2D = null

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
			add_theme_stylebox_override("panel", default_color)
		else:
			mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
			$Disabled.visible = false

func _on_mouse_entered():
	print("mouse_entered")
	if !_disabled:
		_hover = true
		if _left_down:
			add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			add_theme_stylebox_override("panel", hover_color)

func _on_mouse_exited():
	if !_disabled:
		_hover = false
		add_theme_stylebox_override("panel", default_color)

func _on_gui_input(event):
	if !_disabled:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					_left_down = true
					add_theme_stylebox_override("panel", down_color)
				else:
					_left_down = false
					if _hover: 
						add_theme_stylebox_override("panel", hover_color)
						on_pressed.emit(self)
