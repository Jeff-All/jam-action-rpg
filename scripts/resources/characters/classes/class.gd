class_name Class

extends Resource

@export var name: String

@export var texture: Texture2D

@export var threat: int
@export var subtlety: int

@export var attack: int
@export var dodge: int

@export var strength: int
@export var agility: int
@export var magic: int

@export var armor: int
@export var durability: int
@export var health: int
@export var stamina: int
@export var mana: int

@export var health_recovery: int
@export var stamina_recovery: int
@export var mana_recovery: int

@export var levels: Dictionary[int, ClassLevel]

func get_header() -> String:
	return name

func get_description() -> String:
	return ""

func get_icon() -> Texture2D:
	return texture
