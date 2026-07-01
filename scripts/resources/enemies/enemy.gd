class_name Enemy

extends Resource

@export var name: String
@export var texture: Texture2D

@export var health: int
@export var armor: int
@export var durability: int
@export var stamina: int
@export var mana: int

@export var dodge: int

func get_enemy_battle() -> EnemyBattle:
	return EnemyBattle.new(self)
