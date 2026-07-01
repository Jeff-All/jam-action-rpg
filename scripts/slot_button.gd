class_name SlotButton

extends Control

signal on_pressed(action_button: SlotButton)
signal on_enter(action_button: SlotButton)
signal on_exit(action_button: SlotButton)
signal on_lock(action_button: SlotButton)

@export var default_color: StyleBox
@export var hover_color: StyleBox
@export var down_color: StyleBox
@export var selected_color: StyleBox

@export var background_active: StyleBox
@export var background_disabled: StyleBox
@export var background_locked: StyleBox

@export var shadow_offset: Vector2

@export var category: String
var value

@export var expand_mode: TextureRect.ExpandMode

var texture_rect: TextureRect
var shadow: TextureRect
var panel: Panel

var texture: Texture2D:
	set(_value):
		texture_rect.texture = _value
		shadow.texture = _value

func _ready():
	texture_rect = $TextureRect
	shadow = $Shadow
	panel = $Panel
	
	texture_rect.expand_mode = expand_mode
	
	shadow.anchor_left = shadow_offset.x
	shadow.anchor_right = shadow_offset.x + 1.0
	shadow.anchor_top = shadow_offset.y
	shadow.anchor_bottom = shadow_offset.y + 1.0

func empty():
	texture = null
	value = null

func disable():
	texture = null
	value = null
	locked = true
	texture_rect.material.set_shader_parameter("index", 0)
	#$MarginContainer/Background.add_theme_stylebox_override("panel", background_disabled)

func enable():
	locked = false
	texture_rect.material.set_shader_parameter("index", 1)
	#$MarginContainer/Background.add_theme_stylebox_override("panel", background_active)

func fill(_value, _offset = null):
	if _offset != null:
		shadow_offset = _offset
	value = _value
	if value != null:
		texture = value.get_icon()
		shadow.anchor_left = shadow_offset.x
		shadow.anchor_right = shadow_offset.x + 1.0
		shadow.anchor_top = shadow_offset.y
		shadow.anchor_bottom = shadow_offset.y + 1.0
	else:
		texture = Global.empty_slotButton.get_icon()

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
			texture_rect.material.set_shader_parameter("index", 3)
			#add_theme_stylebox_override("panel", selected_color)
			mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
		else: 
			texture_rect.material.set_shader_parameter("index", 1)
			#add_theme_stylebox_override("panel", default_color)
			if !_locked && selectable:
				mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND

func _on_mouse_entered():
	on_enter.emit(self)
	_hover = true
	if !_selected && !_locked:
		if _left_down:
			texture_rect.material.set_shader_parameter("index", 4)
			#add_theme_stylebox_override("panel", down_color)
		if !_left_down:
			texture_rect.material.set_shader_parameter("index", 2)
			#add_theme_stylebox_override("panel", hover_color)

func _on_mouse_exited():
	on_exit.emit(self)
	_hover = false
	if !_selected && !_locked:
		texture_rect.material.set_shader_parameter("index", 1)
		#add_theme_stylebox_override("panel", default_color)

func _on_gui_input(event):
	if event is InputEventMouseButton and !_locked:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed() and !_selected:
				_left_down = true
				texture_rect.material.set_shader_parameter("index", 4)
				#add_theme_stylebox_override("panel", down_color)
			else:
				_left_down = false
				if _hover and !_selected: 
					texture_rect.material.set_shader_parameter("index", 2)
					#add_theme_stylebox_override("panel", hover_color)
					on_pressed.emit(self)
