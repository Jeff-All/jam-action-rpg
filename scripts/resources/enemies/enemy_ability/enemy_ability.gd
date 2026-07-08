class_name EnemyAbility

extends Resource

@export var name: String
@export var cooldown: float
@export var cast_time: float
@export var cast_variability: float
@export var texture: Texture2D
@export var floats: Dictionary[String, float]

@export var buff: BuffPC
