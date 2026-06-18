class_name SlotButton

extends PanelContainer

signal on_pressed(action_button: SlotButton)
signal on_enter(action_button: SlotButton)
signal on_exit(action_button: SlotButton)
signal on_lock(action_button: ActionButton)

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox
@export var selected_color: StyleBox

@export var background_active: StyleBox
@export var background_disabled: StyleBox
@export var background_locked: StyleBox

@export var category: String
var value

var texture: Texture2D:
	set(_value):
		$MarginContainer/Background/MarginContainer/TextureRect.texture = _value

func empty():
	texture = null
	value = null

func disable():
	texture = null
	value = null
	locked = true
	$MarginContainer/Background.add_theme_stylebox_override("panel", background_disabled)

func enable():
	locked = false
	$MarginContainer/Background.add_theme_stylebox_override("panel", background_active)

func fill(_value):
	value = _value
	texture = value.get_icon()

var _hover: bool = false
var _left_down: bool = false
var _selected: bool = false
var _locked: bool = false
var selectable: bool = true

var locked: bool:
	set(_value):
		_locked = _value
		if _locked:
			mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
			on_lock.emit(self)
		else: if selectable: 
			mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
	get: return _locked

var selected: bool:
	set(_value):
		_selected = _value
		if _selected:
			add_theme_stylebox_override("panel", selected_color)
			mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
		else: 
			add_theme_stylebox_override("panel", default_color)
			if !_locked && selectable:
				mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND

func _on_mouse_entered():
	on_enter.emit(self)
	_hover = true
	if !_selected && !_locked:
		if _left_down:
			add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			add_theme_stylebox_override("panel", hover_color)

func _on_mouse_exited():
	on_exit.emit(self)
	_hover = false
	if !_selected && !_locked:
		add_theme_stylebox_override("panel", default_color)

func _on_gui_input(event):
	if event is InputEventMouseButton and !_locked:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed() and !_selected:
				_left_down = true
				add_theme_stylebox_override("panel", down_color)
			else:
				_left_down = false
				if _hover and !_selected: 
					add_theme_stylebox_override("panel", hover_color)
					on_pressed.emit(self)
