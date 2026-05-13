class_name ActionButton

extends Container

var key: String

signal on_pressed(action_button: ActionButton)
signal on_enter(action_button: ActionButton)
signal on_exit(action_button: ActionButton)
signal on_lock(action_button: ActionButton)

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox
@export var selected_color: StyleBox

@export var action: ActionState:
	get: return _action

var character: Character
var keybind: String = ""

func _input(event):
	if _can_afford && !_on_cooldown() && keybind != "":
		if event.is_action_pressed(keybind):
			print("keybind %s pressed" % keybind)
			if _hover and !_selected: 
					$Background.add_theme_stylebox_override("panel", hover_color)
			on_pressed.emit(self)

func set_action(_character: Character, character_index: int, ability_index: int, value: ActionState):
	character = _character
	_action = value
	if _action != null:
		if _character is Enemy:
			$MarginContainer/Keybind.visible = false
		else:
			$MarginContainer/Keybind.visible = true
			keybind = Global.action_button_map[character_index][ability_index]
			$MarginContainer/Keybind.texture = Global.action_button_art_map[keybind]
			_action.on_update_cooldown.connect(update_cooldown)
		$MarginContainer/Image.texture = _action.base.texture
		$MarginContainer/CostBar.set_cost(character, _action.base.cost)

var selectable: bool = true

var selected: bool:
	set(value):
		_selected = value
		if _selected:
			$Background.add_theme_stylebox_override("panel", selected_color)
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
		else: 
			$Background.add_theme_stylebox_override("panel", default_color)
			if !_locked && selectable:
				$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND

var can_afford: bool:
	set(value):
		_can_afford = value
		print("can_afford %s so %s" % [value, !_can_afford])
		$MarginContainer/Overlay.visible = !_can_afford
		if _can_afford && !locked && selectable:
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
		else:
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW

var _can_afford: bool = false

var locked: bool:
	set(value):
		_locked = value
		$MarginContainer/Overlay.visible = _locked
		if _locked:
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
			on_lock.emit(self)
		else: if selectable: 
			$Background.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND

var _locked: bool

var _action: ActionState

var _hover: bool = false
var _left_down: bool = false
var _selected: bool = false

func _ready():
	$Background.add_theme_stylebox_override("panel", default_color)
	if _action != null:
		$MarginContainer/Image.texture = _action.base.texture
	$MarginContainer/Cooldown.custom_minimum_size = Vector2(0.0,0.0)

func _on_keybind_pressed():
	pass

func _on_keybind_released():
	pass

func _on_background_mouse_entered():
	on_enter.emit(self)
	_hover = true
	if !_selected && !_locked && _can_afford:
		if _left_down:
			$Background.add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			$Background.add_theme_stylebox_override("panel", hover_color)

func _on_background_mouse_exited():
	on_exit.emit(self)
	_hover = false
	if !_selected && !_locked && _can_afford:
		$Background.add_theme_stylebox_override("panel", default_color)

func _on_background_gui_input(event):
	if _can_afford && !_on_cooldown():
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed() and !_selected and selectable:
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

func update_can_afford():
	can_afford = _action.base.can_afford(character)

var _cooldown: float = 0.0

func _on_cooldown()->bool:
	return _cooldown > 0

func update_cooldown(val: float):
	_cooldown = val
	print("update_cooldown %s | %s" % [$MarginContainer/BG.size.y, val])
	$MarginContainer/Cooldown.custom_minimum_size = Vector2(0.0, $MarginContainer/BG.size.y * val)
