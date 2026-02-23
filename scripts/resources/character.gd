class_name Character
extends Resource

signal on_death(character)

signal on_cur_durability_change(character)
signal on_cur_health_change(character)
signal on_cur_stamina_change(character)
signal on_cur_mana_change(character)

signal on_take_damage(damage: int)

signal on_turn_order_mouse_enter(character)
signal on_turn_order_mouse_exit(character)

signal on_set_active(character, value: bool)
signal on_set_highlight(character, value: bool)

enum Attribute { STRENGTH, AGILITY, MAGIC }
enum CharacterResource { DURABILITY, HEALTH, STAMINA, MANA}

@export var name: String:
	get():
		return _get_name()

func _get_name() -> String:
	return "default name"

@export var count: int

@export var texture: Texture2D

@export var strength: int
@export var agility: int
@export var magic: int

@export var armor: int
@export var max_durability: int
@export var max_health: int
@export var max_stamina: int
@export var max_mana: int

@export var cur_durability: int:
	set = _set_cur_durability
@export var cur_health: int:
	set = _set_cur_health
@export var cur_stamina: int:
	set = _set_cur_stamina
@export var cur_mana: int:
	set = _set_cur_mana

@export var health_recovery: int
@export var stamina_recovery: int
@export var mana_recovery: int

@export var attack: int
@export var defense: int

@export var weapon: Weapon

var dead: bool:
	get():
		return cur_health <= 0

var actions: Array[Action]:
	get = _get_actions

func _get_actions() -> Array[Action]:
	return []

func get_attribute(attribute: Attribute):
	match attribute:
		Attribute.STRENGTH: return strength
		Attribute.AGILITY: return agility
		Attribute.MAGIC: return magic

func get_resource(resource: CharacterResource) -> int:
	match resource:
		CharacterResource.DURABILITY: return cur_durability
		CharacterResource.HEALTH: return cur_health
		CharacterResource.STAMINA: return cur_stamina
		CharacterResource.MANA: return cur_mana
	return 0

func set_resource(resource: CharacterResource, value: int):
	match resource:
		CharacterResource.DURABILITY: cur_durability = min(max_durability, value)
		CharacterResource.HEALTH: cur_health = min(max_health, value)
		CharacterResource.STAMINA: cur_stamina = min(max_stamina, value)
		CharacterResource.MANA: cur_mana = min(max_mana, value)

func modify_resource(resource: CharacterResource, value: int):
	match resource:
		CharacterResource.DURABILITY: cur_durability = min(max_durability, cur_durability + value)
		CharacterResource.HEALTH: cur_health = min(max_health, cur_health + value)
		CharacterResource.STAMINA: cur_stamina = min(max_stamina, cur_stamina + value)
		CharacterResource.MANA: cur_mana = min(max_mana, cur_mana + value)

func take_damage(damage: int):
	var actual_damage = damage
	if cur_durability > 0:
		actual_damage -= armor
		if damage >= armor:
			cur_durability -= 1
	
	actual_damage = max(0, actual_damage)
	
	cur_health -= actual_damage
	
	on_take_damage.emit(actual_damage)

func _set_cur_durability(new_durability: int):
	if cur_durability != new_durability:
		cur_durability = min(max_durability, max(0, new_durability))
	on_cur_durability_change.emit(self)

func _set_cur_health(new_health: int):
	var bound_health = max(0, new_health)
	if cur_health != bound_health:
		cur_health = bound_health
		on_cur_health_change.emit(self)
	if cur_health <= 0:
		print("character %s death" % name)
		on_death.emit(self)

func _set_cur_stamina(new_stamina: int):
	if cur_stamina != new_stamina:
		cur_stamina = min(max_stamina, max(0, new_stamina))
		on_cur_stamina_change.emit(self)

func _set_cur_mana(new_mana: int):
	if cur_mana != new_mana:
		cur_mana = min(max_mana, max(0, new_mana))
		on_cur_mana_change.emit(self)

var active: bool:
	set(value):
		_active = value
		on_set_active.emit(self, _active)

var _active: bool = false

var highlight: bool:
	set(value):
		_highlight = value
		on_set_highlight.emit(self, value)

var _highlight: bool = false

func turn_order_mouse_enter(_ui: TurnOrderCharacter):
	on_turn_order_mouse_enter.emit(self)

func turn_order_mouse_exit(_ui :TurnOrderCharacter):
	on_turn_order_mouse_exit.emit(self)

func end_turn():
	cur_health = cur_health + health_recovery
	cur_mana = cur_mana + mana_recovery
	cur_stamina = cur_stamina + stamina_recovery


signal on_start_cast(action: Action)
signal on_update_cast(progress: float)
signal on_finish_cast()

var cur_cast: float = 0.0
var action_being_cast: Action = null
var target_of_cast: Character = null

func start_cast(action: Action, target: Character):
	cur_cast = 0.0
	action_being_cast = action
	target_of_cast = target
	on_start_cast.emit(action)

func update_cast(delta: float):
	cur_cast += delta
	if cur_cast > action_being_cast.cast_time:
		finish_cast()
	else:
		on_update_cast.emit(cur_cast / action_being_cast.cast_time)

func finish_cast():
	cur_cast = 0.0
	action_being_cast.apply(target_of_cast)
	action_being_cast = null
	target_of_cast = null
	on_finish_cast.emit()

func process_tick(delta: float):
	if action_being_cast != null:
		update_cast(delta)
