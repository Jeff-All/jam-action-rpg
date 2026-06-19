class_name CharacterBase

extends Resource

@export var race: Race
@export var class_: Class
@export var ability: Ability
@export var trait_: Trait
@export var weapon: Weapon
@export var armor: Armor

func get_character_campaign() -> CharacterCampaign:
	return CharacterCampaign.new(self)

func _to_string() -> String:
	return "Race: %s\nClass: %s\nAbility: %s\nTrait: %s\nWeapon: %s\nArmor: %s" %[
		race, class_, ability, trait_, weapon, armor,
	]
