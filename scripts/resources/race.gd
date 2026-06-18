class_name Race

extends Resource

@export var name: String

@export var texture: Texture2D

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
@export var defenses: Array[Action]

func apply(character: Character):
	character.strength += strength
	character.agility += agility
	character.magic += magic
	
	character.armor += armor
	character.max_durability += durability
	character.max_health += health
	character.max_stamina += stamina
	character.max_mana += mana
	
	character.cur_durability += durability
	character.cur_health += health
	character.cur_stamina += stamina
	character.cur_mana += mana
	
	character.health_recovery += health_recovery
	character.stamina_recovery += stamina_recovery
	character.mana_recovery += mana_recovery

func remove(character: Character):
	character.strength -= strength
	character.agility -= agility
	character.magic -= magic
	
	character.armor -= armor
	character.max_durability -= durability
	character.max_health -= health
	character.max_stamina -= stamina
	character.max_mana -= mana
	
	character.health_recovery -= health_recovery
	character.stamina_recovery -= stamina_recovery
	character.mana_recovery -= mana_recovery

func get_header() -> String:
	return name

func get_description() -> String:
	return ""

func get_icon() -> Texture2D:
	return texture
