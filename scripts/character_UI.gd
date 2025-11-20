class_name CharacterUI
extends MarginContainer

signal on_pressed(character: CharacterUI)
signal on_hover(character: CharacterUI)
signal on_leave(character: CharacterUI)

@export var active: bool:
	set(value):
		$StateButton.active = value

@export var available: bool:
	set(value):
		$StateButton.available = value

@export var character: Character:
	set = _set_character

func reset():
	active = false
	available = false

func _set_character(new_character: Character):
	_unbind_character()
	
	character = new_character
	
	if character == null:
		return
	
	$Status/Armor.set_value(character.cur_armor)
	$Status/Health.set_value(character.cur_health)
	$Status/Stamina.set_value(character.cur_stamina)
	$Status/Mana.set_value(character.cur_mana)
	
	_bind_character()

func _unbind_character():
	if character != null:
		character.on_cur_armor_change.disconnect(_armor_change)
		character.on_cur_health_change.disconnect(_health_change)
		character.on_cur_stamina_change.disconnect(_stamina_change)
		character.on_cur_mana_change.disconnect(_mana_change)
		
		character.on_set_active.disconnect(_on_set_active)
		
		character.on_turn_order_mouse_enter.disconnect(_on_turn_order_mouse_enter)
		character.on_turn_order_mouse_exit.disconnect(_on_turn_order_mouse_enter)

func _bind_character():
	character.on_cur_armor_change.connect(_armor_change)
	character.on_cur_health_change.connect(_health_change)
	character.on_cur_stamina_change.connect(_stamina_change)
	character.on_cur_mana_change.connect(_mana_change)
	
	character.on_set_active.connect(_on_set_active)
	
	character.on_turn_order_mouse_enter.connect(_on_turn_order_mouse_enter)
	character.on_turn_order_mouse_exit.connect(_on_turn_order_mouse_exit)
	
	$ImageContainer/Image.texture = character.textures.big

func _on_button_pressed():
	on_pressed.emit(self)

func _armor_change(_character):
	$Status/Armor.set_value(character.cur_armor)

func _health_change(_character):
	$Status/Health.set_value(character.cur_health)

func _stamina_change(_character):
	$Status/Stamina.set_value(character.cur_stamina)

func _mana_change(_character):
	$Status/Mana.set_value(character.cur_mana)

func _on_hover():
	print("hover %s.%s" % [character.name, character.count])
	on_hover.emit(self)

func _on_leave():
	on_leave.emit(self)

func _on_turn_order_mouse_enter(_ui: Character):
	print("character._on_turn_order_mouse_enter")
	$StateButton.highlight = true

func _on_turn_order_mouse_exit(_ui: Character):
	print("character._on_turn_order_mouse_exit")
	$StateButton.highlight = false

func _on_set_active(_character: Character, value: bool):
	active = value
