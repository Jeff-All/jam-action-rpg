class_name Armor

extends EquippableItem

enum ArmorClass{ NONE, ROBE, LIGHT, MEDIUM, HEAVY }

@export var armor_class: ArmorClass

func equip(character: CharacterCampaign):
	character.armor = self
	
	super(character)

func unequip(character: CharacterCampaign):
	character.armor = null
	
	super(character)
