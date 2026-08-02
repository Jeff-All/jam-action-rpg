class_name Weapon

extends EquippableItem

@export var _min_damage: int
@export var _max_damage: int
@export var _damage_type: String
@export var _hit: int
@export var _speed: float

var min_damage: int: 
	get: return _min_damage
var max_damage: int:
	get: return _max_damage
var damage_type: String:
	get: return _damage_type
var hit: int:
	get: return _hit	
var speed: float:
	get: return _speed

func get_header() -> String:
	return name

func get_description() -> String:
	return "Damage: %s - %s\nType: %s\nHit: %s%%\nSpeed: %s" % [
		min_damage, max_damage, damage_type, hit, speed]

func _to_string() -> String:
	return name

func get_icon() -> Texture2D:
	return texture

func equip(character: CharacterCampaign):
	character.weapon = self
	
	super(character)

func unequip(character: CharacterCampaign):
	character.weapon = null
	
	super(character)
