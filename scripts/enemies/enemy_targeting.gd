class_name EnemyTargeting

extends HBoxContainer

signal on_cast_end(ability: EnemyAbility, target)

var animation_player: AnimationPlayer
var ability_texture_rect: TextureRect
var target_texture_rect: TextureRect 

var _ability: EnemyAbility
var _target
var _is_casting: bool = false

var ability:
	set(value):
		_ability = value
		ability_texture_rect.texture = value.texture
	get:
		return _ability

var target:
	set(value):
		_target = value
		target_texture_rect.texture = value.texture
	get:
		return _target

var is_casting: bool:
	get:
		return _is_casting

func process_animations(delta: float):
	animation_player.advance(delta)

func _ready():
	animation_player = $AnimationPlayer
	ability_texture_rect = $Targeting/MarginContainer/HBoxContainer/Ability
	target_texture_rect = $Targeting/MarginContainer/HBoxContainer/Target

func _on_cast_end():
	is_casting = false
	on_cast_end.emit(_ability, _target)

func start_cast(to_cast: EnemyAbility, to_target, cast_time: float):
	is_casting = true
	ability = to_cast
	target = to_target
	animation_player.speed_scale = 1 / cast_time
	animation_player.current_animation = "cast_animation"

func stop_casting():
	is_casting = false
