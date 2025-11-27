class_name BaseEnemy

extends Resource

@export var name: String

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

@export var textures: Array[Texture2D]

static var count: int

func build_enemy() -> Enemy:
	var enemy = Enemy.new()
	
	enemy.base = self
	
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
	
	enemy.cur_durability = durability
	enemy.cur_health = health
	enemy.cur_stamina = stamina
	enemy.cur_mana = mana
	
	enemy.health_recovery = health_recovery
	enemy.stamina_recovery = stamina_recovery
	enemy.mana_recovery = mana_recovery
	
	enemy.texture = textures[count % textures.size()]
	
	count += 1
	
	return enemy
