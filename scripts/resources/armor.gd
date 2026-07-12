class_name Armor

extends Resource

enum ArmorClass{ NONE, ROBE, LIGHT, MEDIUM, HEAVY }

@export var name: String
@export var armor_class: ArmorClass
@export var texture: Texture2D

@export var attributes: Dictionary[CharacterCampaign.Attributes, int]
@export var resources: Dictionary[CharacterCampaign.Resources, int]
@export var recovery: Dictionary[CharacterCampaign.Resources, int]

@export var dodge: int

func get_header() -> String:
	return name

func get_description() -> String:
	return ""

func _to_string() -> String:
	return name

func get_icon() -> Texture2D:
	return texture

func equip(character: CharacterCampaign):
	character.armor = self
	
	for cur in attributes:
		character.attributes[cur] += attributes[cur]
	
	for cur in resources:
		character.resources[cur] = character.resources[cur] + resources[cur]
	
	for cur in recovery:
		character.recovery[cur] = character.recovery[cur] + recovery[cur]
	
	character.dodge += dodge

func unequip(character: CharacterCampaign):
	character.armor = null
	
	for cur in attributes:
		character.attributes[cur] += attributes[cur]
	
	for cur in resources:
		character.resources[cur] = character.resources[cur] - resources[cur]
	
	for cur in recovery:
		character.recovery[cur] = character.recovery[cur] - recovery[cur]
	
	character.dodge -= dodge
