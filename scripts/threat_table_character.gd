class_name ThreatTableCharacter

extends PanelContainer

signal on_mouse_enter(turn_order_character: TurnOrderCharacter)
signal on_mouse_exit(turn_order_character: TurnOrderCharacter)

@export var default_color: StyleBox
@export var selected_color: StyleBox
@export var hover_color: StyleBox

var hover: bool = false

var character: Character:
	set(value):
		_character = value
		if _character != null:
			$MarginContainer/Image.texture = _character.texture
			_character.on_death.connect(_on_death)
		else:
			$MarginContainer/Image.texture = null

var _character: Character

var selected: bool:
	set(value):
		_selected = value
		if _selected:
			add_theme_stylebox_override("panel", selected_color)
		else:
			if hover:
				add_theme_stylebox_override("panel", hover_color)
			else:
				add_theme_stylebox_override("panel", default_color)

var _selected: bool = false

func clear():
	character = null
	selected = false
	visible = false

func _on_mouse_entered():
	hover = true
	add_theme_stylebox_override("panel", hover_color)
	on_mouse_enter.emit(self)

func _on_mouse_exited():
	hover = false
	if _selected:
		add_theme_stylebox_override("panel", selected_color)
	else:
		add_theme_stylebox_override("panel", default_color)
	on_mouse_exit.emit(self)

func _on_death(_c: Character):
	$MarginContainer/DeathPanel.visible = true
