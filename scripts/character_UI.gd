class_name CharacterUI
extends MarginContainer

signal on_pressed(character: CharacterUI)
signal on_hover(character: CharacterUI)
signal on_leave(character: CharacterUI)

var animation: AnimationPlayer

var center: Vector2:
	get():
		return global_position + (size / 2)

@export var active: bool:
	set(value):
		$StateButton.active = value

@export var available: bool:
	set(value):
		$StateButton.available = value

@export var highlight: bool:
	set(value):
		$StateButton.highlight = value

@export var dead: bool:
	set(value):
		$ImageContainer/DeathOverlay.visible = true

@export var character: Character:
	set = _set_character

func _ready():
	animation = $AnimationPlayer

func reset():
	active = false
	available = false

func _set_character(new_character: Character):
	_unbind_character()
	
	character = new_character
	
	if character == null:
		return
	
	$VBoxContainer/HBoxContainer/CenterCotnainer/Armor.text = "%s" % character.armor
	$VBoxContainer/Status/Durability.set_value(character.cur_durability)
	$VBoxContainer/Status/Health.set_value(character.cur_health)
	$VBoxContainer/Status/Stamina.set_value(character.cur_stamina)
	$VBoxContainer/Status/Mana.set_value(character.cur_mana)
	
	if new_character is Enemy:
		$ImageContainer/VBoxContainer2/ThreatTable.bind_table(new_character.threat_table)
	else:
		$ImageContainer/VBoxContainer2/ThreatTable.visible = false
	
	_bind_character()

func _unbind_character():
	if character != null:
		character.on_cur_durability_change.disconnect(_durability_change)
		character.on_cur_health_change.disconnect(_health_change)
		character.on_cur_stamina_change.disconnect(_stamina_change)
		character.on_cur_mana_change.disconnect(_mana_change)
		
		character.on_take_damage.disconnect(_take_damage)
		
		character.on_set_active.disconnect(_on_set_active)
		character.on_set_highlight.disconnect(_on_set_highlight)
		
		character.on_turn_order_mouse_enter.disconnect(_on_turn_order_mouse_enter)
		character.on_turn_order_mouse_exit.disconnect(_on_turn_order_mouse_enter)
		
		character.on_death.disconnect(_on_death)

func _bind_character():
	character.on_cur_durability_change.connect(_durability_change)
	character.on_cur_health_change.connect(_health_change)
	character.on_cur_stamina_change.connect(_stamina_change)
	character.on_cur_mana_change.connect(_mana_change)
	
	character.on_take_damage.connect(_take_damage)
	
	character.on_set_active.connect(_on_set_active)
	character.on_set_highlight.connect(_on_set_highlight)
	
	character.on_turn_order_mouse_enter.connect(_on_turn_order_mouse_enter)
	character.on_turn_order_mouse_exit.connect(_on_turn_order_mouse_exit)
	
	character.on_death.connect(_on_death)
	
	$ImageContainer/Image.texture = character.texture

func _on_button_pressed():
	on_pressed.emit(self)

func _durability_change(_character):
	$VBoxContainer/Status/Durability.set_value(character.cur_durability)

func _health_change(_character):
	$VBoxContainer/Status/Health.set_value(character.cur_health)

func _stamina_change(_character):
	$VBoxContainer/Status/Stamina.set_value(character.cur_stamina)

func _mana_change(_character):
	$VBoxContainer/Status/Mana.set_value(character.cur_mana)

func _take_damage(_damage: int):
	animation.play("take_damage")

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

func _on_set_highlight(_c: Character, value: bool):
	highlight = value

func _on_death(_c: Character):
	dead = true
