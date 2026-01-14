class_name CharacterUI
extends MarginContainer

signal on_pressed(character: CharacterUI)
signal on_hover(character: CharacterUI)
signal on_leave(character: CharacterUI)

signal on_action_button_pressed(action_button: ActionButton)
signal on_action_button_entered(action_button: ActionButton)
signal on_action_button_exited(action_button: ActionButton)

var animation: AnimationPlayer
var combat_text: CombatText
var action_button_grid: ActionButtonGrid

var center: Vector2:
	get():
		return global_position + (size / 2)

@export var active: bool:
	set(value):
		$VBoxContainer2/MarginContainer/StateButton.active = value

@export var available: bool:
	set(value):
		$VBoxContainer2/MarginContainer/StateButton.available = value

@export var highlight: bool:
	set(value):
		$VBoxContainer2/MarginContainer/StateButton.highlight = value

@export var dead: bool:
	set(value):
		$VBoxContainer2/MarginContainer/ImageContainer/DeathOverlay.visible = true

@export var character: Character:
	set = _set_character

var cast_bar: CastBar

func _ready():
	animation = $AnimationPlayer
	
	cast_bar = $VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/CastBar
	action_button_grid = $VBoxContainer2/ActionButtonGrid

func reset():
	active = false
	available = false
	action_button_grid.reset()

func _set_character(new_character: Character):
	_unbind_character()
	
	character = new_character
	
	if character == null:
		return
	
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/CenterCotnainer/Armor.text = "%s" % character.armor
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Durability.set_value(character.cur_durability)
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Health.set_value(character.cur_health)
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Stamina.set_value(character.cur_stamina)
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Mana.set_value(character.cur_mana)
	
	if new_character is Enemy:
		$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer2/ThreatTable.bind_table(new_character.threat_table)
	else:
		$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer2/ThreatTable.visible = false
	
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
		
		character.on_start_cast.disconnect(cast_bar.start_cast)
		character.on_update_cast.disconnect(cast_bar.update_cast)
		character.on_finish_cast.disconnect(cast_bar.finish_cast)

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
	
	character.on_start_cast.connect(cast_bar.start_cast)
	character.on_update_cast.connect(cast_bar.update_cast)
	character.on_finish_cast.connect(cast_bar.finish_cast)
	
	action_button_grid.bind_actions(character)
	
	$VBoxContainer2/MarginContainer/ImageContainer/Image.texture = character.texture

func _on_button_pressed():
	on_pressed.emit(self)

func _durability_change(_character):
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Durability.set_value(character.cur_durability)

func _health_change(_character):
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Health.set_value(character.cur_health)

func _stamina_change(_character):
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Stamina.set_value(character.cur_stamina)

func _mana_change(_character):
	$VBoxContainer2/MarginContainer/ImageContainer/VBoxContainer/Status/Mana.set_value(character.cur_mana)

func _take_damage(damage: int):
	combat_text.show_combat_text(center, "%s" % damage)
	animation.play("take_damage")

func _on_hover():
	print("hover %s.%s" % [character.name, character.count])
	on_hover.emit(self)

func _on_leave():
	on_leave.emit(self)

func _on_turn_order_mouse_enter(_ui: Character):
	print("character._on_turn_order_mouse_enter")
	$VBoxContainer2/MarginContainer/StateButton.highlight = true

func _on_turn_order_mouse_exit(_ui: Character):
	print("character._on_turn_order_mouse_exit")
	$VBoxContainer2/MarginContainer/StateButton.highlight = false

func _on_set_active(_character: Character, value: bool):
	active = value

func _on_set_highlight(_c: Character, value: bool):
	highlight = value

func _on_death(_c: Character):
	dead = true

func _on_action_button_pressed(action_button: ActionButton):
	on_action_button_pressed.emit(action_button)

func _on_action_button_entered(action_button: ActionButton):
	on_action_button_entered.emit(action_button)

func _on_action_button_exited(action_button: ActionButton):
	on_action_button_exited.emit(action_button)
