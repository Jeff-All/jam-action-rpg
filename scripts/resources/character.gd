class_name Character
extends Resource

signal on_cur_armor_change(character)
signal on_cur_health_change(character)
signal on_cur_stamina_change(character)
signal on_cur_mana_change(character)

signal on_turn_order_mouse_enter(character)
signal on_turn_order_mouse_exit(character)

signal on_set_active(character, value: bool)
signal on_set_highlight(character, value: bool)

enum Attribute { STRENGTH, AGILITY, MAGIC }

@export var base_character: BaseCharacter

@export var name: String
@export var count: int

@export var textures: CharacterTextureGroup

@export var max_armor: int
@export var max_health: int
@export var max_stamina: int
@export var max_mana: int

@export var cur_armor: int:
	set = _set_cur_armor
@export var cur_health: int:
	set = _set_cur_health
@export var cur_stamina: int:
	set = _set_cur_stamina
@export var cur_mana: int:
	set = _set_cur_mana

@export var repair: int
@export var regeneration: int
@export var recovery: int
@export var revival: int

@export var attributes: Dictionary[Attribute, int]

@export var attack: int
@export var defense: int

func _init(_base_character: BaseCharacter = null, _count: int = 0):
	if _base_character == null:
		return
	base_character = _base_character
	name = _base_character.name
	count = _count
	
	max_armor = _base_character.max_armor
	max_health = _base_character.max_health
	max_stamina = _base_character.max_stamina
	
	cur_armor = _base_character.cur_armor
	cur_health = _base_character.cur_health
	cur_stamina = _base_character.cur_stamina
	cur_mana = _base_character.cur_mana
	
	repair = _base_character.repair
	regeneration = _base_character.regeneration
	recovery = _base_character.recovery
	revival = _base_character.revival
	
	for cur_attribute in _base_character.attributes:
		attributes[cur_attribute] = _base_character.attributes[cur_attribute]
	
	attack = _base_character.attack
	defense = _base_character.defense
	
	textures = base_character.texture_groups[count]

func _set_cur_armor(new_armor: int):
	if cur_armor != new_armor:
		cur_armor = new_armor
		on_cur_armor_change.emit(self)

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
