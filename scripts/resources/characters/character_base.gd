class_name CharacterBase

extends Resource

var index: int
@export var race: Race
@export var class_: Class
@export var ability: Ability
@export var trait_: Trait
@export var weapon: Weapon
@export var armor: Armor

func _init(_index: int):
	index = _index

func get_character_campaign(attack: Ability) -> CharacterCampaign:
	var character = CharacterCampaign.new(self)
	
	character.race = race
	character._class = class_
	character.armor = armor
	character.weapon = weapon
	character.traits.append(trait_)
	character.available_traits.append(trait_)
	character.abilities.append(attack)
	character.available_abilities.append(attack)
	character.abilities.append(ability)
	character.available_abilities.append(ability)
	
	return character

func _to_string() -> String:
	return "Race: %s\nClass: %s\nAbility: %s\nTrait: %s\nWeapon: %s\nArmor: %s" %[
		race, class_, ability, trait_, weapon, armor,
	]
