class_name Class

extends Resource

@export var name: String

@export var threat: int

@export var attack: int
@export var defense: int

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

@export var actions: Array[Action]

func apply(character: Character):
	character.strength += strength
	character.agilty += agility
	character.magic += magic
	
	character.attack += attack
	character.defense += defense
	
	character.max_armor += armor
	character.max_durability += durability
	character.max_health += health
	character.max_stamina += stamina
	character.max_mana += mana

func remove(character: Character):
	character.strength -= strength
	character.agility -= agility
	character.magic -= magic
	
	character.attack -= attack
	character.defense -= defense
	
	character.max_armor -= armor
	character.max_durability -= durability
	character.max_health -= health
	character.max_stamina -= stamina
	character.max_mana -= mana
