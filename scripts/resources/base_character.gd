class_name BaseCharacter
extends Resource

@export var name: String

@export var texture_groups: Array[CharacterTextureGroup]

@export var max_armor: int
@export var max_health: int
@export var max_stamina: int
@export var max_mana: int

@export var cur_armor: int
@export var cur_health: int
@export var cur_stamina: int
@export var cur_mana: int

@export var repair: int
@export var regeneration: int
@export var recovery: int
@export var revival: int

@export var actions: Array[Action]

@export var attributes: Dictionary[Character.Attribute, int]

@export var attack: int
@export var defense: int
