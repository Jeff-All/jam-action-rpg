class_name Weapon

extends Resource

@export var name: String
@export var texture: Texture2D
@export var min_damage: int
@export var max_damage: int
@export var damage_type: String
@export var hit: int
@export var speed: float

@export var attributes: Dictionary[CharacterCampaign.Attributes, int]
@export var resources: Dictionary[CharacterCampaign.Resources, int]
@export var recovery: Dictionary[CharacterCampaign.Resources, int]

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
	
	for cur in attributes:
		character.attributes[cur] += attributes[cur]
	
	for cur in resources:
		character.resources[cur] = character.resources[cur] + resources[cur]
	
	for cur in recovery:
		character.recovery[cur] = character.recovery[cur] + recovery[cur]

func unequip(character: CharacterCampaign):
	character.weapon = null
	
	for cur in attributes:
		character.attributes[cur] += attributes[cur]
	
	for cur in resources:
		character.resources[cur] = character.resources[cur] - resources[cur]
	
	for cur in recovery:
		character.recovery[cur] = character.recovery[cur] - recovery[cur]
