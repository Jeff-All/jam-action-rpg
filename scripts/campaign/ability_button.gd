class_name AbilityButton

extends PanelContainer

@export var grayout_theme: StyleBoxFlat
@export var cant_afford_theme: StyleBoxFlat

var sub_view_port_container: SubViewportContainer
var animation_player: AnimationPlayer
var grayout: Panel

var can_afford: bool = true
var on_cooldown: bool = false

func _ready():
	sub_view_port_container = $SubViewportContainer
	
	animation_player = $AnimationPlayer
	grayout = $SubViewportContainer/SubViewport/TextureRect2/MarginContainer/VBoxContainer/Grayout/Panel4
	
	grayout.add_theme_stylebox_override("panel", grayout_theme)

func _on_mouse_entered():
	sub_view_port_container.material.set_shader_parameter("index", 1)

func _on_mouse_exited():
	sub_view_port_container.material.set_shader_parameter("index", 0)

func _on_cooldown_started(duration: float):
	on_cooldown = true
	animation_player.stop()
	animation_player.play("ability_cooldown", -1, 1/duration)

func _on_cooldown_animation_ended():
	on_cooldown = false
	if can_afford:
		animation_player.play("ability_flash")
	else:
		animation_player.play("ability_pre_flash")

func _on_flash_animation_ended():
	if can_afford:
		grayout.add_theme_stylebox_override("panel", grayout_theme)

func _on_cant_afford():
	can_afford = false
	grayout.add_theme_stylebox_override("panel", cant_afford_theme)
	if !on_cooldown:
		animation_player.stop()
		animation_player.play("ability_pre_flash")

func _on_can_afford():
	can_afford = true
	if !on_cooldown:
		animation_player.stop()
		animation_player.play("ability_flash")
	else:
		grayout.add_theme_stylebox_override("panel", grayout_theme)
