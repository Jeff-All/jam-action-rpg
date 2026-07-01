class_name EnemyPane

extends MarginContainer

var texture_rect: TextureRect
var animation_player: AnimationPlayer

var _enemy: Enemy

var enemy: Enemy:
	set(value):
		_enemy = value
		texture_rect.texture = _enemy.texture

var flip: bool:
	set(value):
		texture_rect.flip_h = value

func _ready():
	texture_rect = $Panel/TextureRect
	animation_player = $AnimationPlayer
