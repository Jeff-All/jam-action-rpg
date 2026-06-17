class_name Weapon

extends Resource

@export var name: String
@export var min_damage: int
@export var max_damage: int
@export var damage_type: String
@export var attribute: Character.Attribute
@export var hit: int
@export var speed: float

func get_header() -> String:
	return name

func get_description() -> String:
	return "Attribute: %s\nDamage: %s - %s\nType: %s\nHit: %s%%\nSpeed: %s" % [
		Character.get_attribute_name(attribute), min_damage, max_damage, damage_type, hit, speed]

func _to_string() -> String:
	return name
