class_name StateButton

extends MarginContainer

signal on_pressed()
signal on_hover()
signal on_leave()

@export var default_color: StyleBox
@export var available_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox
@export var active_color: StyleBox
@export var highlight_color: StyleBox

var _hover: bool = false
var _left_down: bool = false

var active: bool:
	set(value):
		$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
		if value:
			if _available:
				$Background.add_theme_stylebox_override("panel", available_color)
				$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
			else:
				$Background.add_theme_stylebox_override("panel", active_color)
		else:
			if !_available:
				$Background.add_theme_stylebox_override("panel", default_color)
		_active = value

var available: bool:
	set(value):
		$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
		if value:
			$Background.add_theme_stylebox_override("panel", available_color)
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
		else:
			if _active:
				$Background.add_theme_stylebox_override("panel", active_color)
			else:
				$Background.add_theme_stylebox_override("panel", default_color)
		_available = value

var _active: bool = false
var _available: bool = false

var highlight: bool:
	set(value):
		if value:
				$Background.add_theme_stylebox_override("panel", highlight_color)
		else:
			if available:
				$Background.add_theme_stylebox_override("panel", available_color)
			else: if _active:
				$Background.add_theme_stylebox_override("panel", active_color)
			else:
				$Background.add_theme_stylebox_override("panel", default_color)

func _ready():
	$Background.add_theme_stylebox_override("panel", default_color)

func _on_background_mouse_entered():
	_hover = true
	if _available:
		if _left_down:
			$Background.add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			$Background.add_theme_stylebox_override("panel", hover_color)
		on_hover.emit()

func _on_background_mouse_exited():
	_hover = false
	if _available:
		$Background.add_theme_stylebox_override("panel", available_color)
		on_leave.emit()

func _on_background_gui_input(event):
	if _available:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					_left_down = true
					$Background.add_theme_stylebox_override("panel", down_color)
				else:
					_left_down = false
					if _hover: 
						$Background.add_theme_stylebox_override("panel", hover_color)
						on_pressed.emit()
