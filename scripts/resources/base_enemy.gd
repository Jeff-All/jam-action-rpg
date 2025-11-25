class_name BaseEnemy

extends Resource

@export var strength: int
@export var agility: int
@export var magic: int

@export var attack: int
@export var defense: int

@export var armor: int
@export var durability: int
@export var health: int
@export var stamina: int
@export var mana: int

@export var health_recovery: int
@export var stamina_recovery: int
@export var mana_recovery: int

@export var textures: CharacterTextureGroup

func build_enemy() -> Enemy:
	var enemy = Enemy.new()
	
	enemy.strength = strength
	enemy.agility = agility
	enemy.magic = magic
	
	enemy.attack = attack
	enemy.defense = defense
	
	enemy.armor = armor
	enemy.max_durability = durability
	enemy.max_health = health
	enemy.max_stamina = stamina
	enemy.max_mana = mana
	
	enemy.health_recovery = health_recovery
	enemy.stamina_recovery = stamina_recovery
	enemy.mana_recovery = mana_recovery
	
	enemy.textures = textures
	
	return enemy
