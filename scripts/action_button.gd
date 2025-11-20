class_name ActionButton

extends Container

signal on_pressed(action_button: ActionButton)

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox
@export var selected_color: StyleBox

@export var action: Action:
	set(value):
		_action = value
		if _action != null:
			$MarginContainer/Image.texture = _action.texture
	get: return _action

var selected: bool:
	set(value):
		_selected = value
		if _selected:
			$Background.add_theme_stylebox_override("panel", selected_color)
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
		else: 
			$Background.add_theme_stylebox_override("panel", default_color)
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND

var _action: Action

var _hover: bool = false
var _left_down: bool = false
var _selected: bool = false

func _ready():
	$Background.add_theme_stylebox_override("panel", default_color)

func _on_background_mouse_entered():
	_hover = true
	if !_selected:
		if _left_down:
			$Background.add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			$Background.add_theme_stylebox_override("panel", hover_color)

func _on_background_mouse_exited():
	_hover = false
	if !_selected:
		$Background.add_theme_stylebox_override("panel", default_color)

func _on_background_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed() and !_selected:
				_left_down = true
				$Background.add_theme_stylebox_override("panel", down_color)
			else:
				_left_down = false
				if _hover and !_selected: 
					$Background.add_theme_stylebox_override("panel", hover_color)
					on_pressed.emit(self)
