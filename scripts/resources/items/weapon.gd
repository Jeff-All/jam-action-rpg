class_name Weapon

extends EquippableItem

@export var min_damage: int
@export var max_damage: int
@export var damage_type: String
@export var hit: int
@export var speed: float

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
