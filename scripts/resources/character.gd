class_name Character
extends Resource

signal on_cur_durability_change(character)
signal on_cur_health_change(character)
signal on_cur_stamina_change(character)
signal on_cur_mana_change(character)

signal on_turn_order_mouse_enter(character)
signal on_turn_order_mouse_exit(character)

signal on_set_active(character, value: bool)
signal on_set_highlight(character, value: bool)

enum Attribute { STRENGTH, AGILITY, MAGIC }

@export var name: String
@export var count: int

@export var textures: CharacterTextureGroup

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

var actions: Array[Action]:
	get = _get_actions

func _get_actions() -> Array[Action]:
	return []

func get_attribute(attribute: Attribute):
	match attribute:
		Attribute.STRENGTH: return strength
		Attribute.AGILITY: return agility
		Attribute.MAGIC: return magic

func _set_cur_durability(new_durability: int):
	if cur_durability != new_durability:
		cur_durability = new_durability
	on_cur_durability_change.emit(self)

func _set_cur_health(new_health: int):
	if cur_health != new_health:
		cur_health = new_health
		on_cur_health_change.emit(self)

func _set_cur_stamina(new_stamina: int):
	if cur_stamina != new_stamina:
		cur_stamina = new_stamina
		on_cur_stamina_change.emit(self)

func _set_cur_mana(new_mana: int):
	if cur_mana != new_mana:
		cur_mana = new_mana
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
