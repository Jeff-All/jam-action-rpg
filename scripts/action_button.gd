class_name ActionButton

extends Container

signal on_pressed(action_button: ActionButton)
signal on_enter(action_button: ActionButton)
signal on_exit(action_button: ActionButton)

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox
@export var selected_color: StyleBox

@export var action: Action:
	get: return _action

func set_action(character: Character, value: Action):
	_action = value
	if _action != null:
		$MarginContainer/Image.texture = _action.texture
		$MarginContainer/CostBar.set_cost(character, _action.cost)

var selected: bool:
	set(value):
		_selected = value
		if _selected:
			$Background.add_theme_stylebox_override("panel", selected_color)
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
		else: 
			$Background.add_theme_stylebox_override("panel", default_color)
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND

var can_afford: bool:
	set(value):
		_can_afford = value
		print("can_afford %s so %s" % [value, !_can_afford])
		$MarginContainer/Overlay.visible = !_can_afford
		if _can_afford:
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
		else:
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW

var _can_afford: bool = false

var _action: Action

var _hover: bool = false
var _left_down: bool = false
var _selected: bool = false

func _ready():
	$Background.add_theme_stylebox_override("panel", default_color)
	if _action != null:
		$MarginContainer/Image.texture = _action.texture

func _on_background_mouse_entered():
	on_enter.emit(self)
	_hover = true
	if !_selected && _can_afford:
		if _left_down:
			$Background.add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			$Background.add_theme_stylebox_override("panel", hover_color)

func _on_background_mouse_exited():
	on_exit.emit(self)
	_hover = false
	if !_selected && _can_afford:
		$Background.add_theme_stylebox_override("panel", default_color)

func _on_background_gui_input(event):
	if _can_afford:
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

func check_hover() -> bool:
	if get_global_rect().has_point(get_global_mouse_position()):
		_on_background_mouse_entered()
		return true
	return false
