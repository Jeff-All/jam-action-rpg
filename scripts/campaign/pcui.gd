class_name PCUI

extends Node

@export var flip: bool = false

var _material: ShaderMaterial

func _ready():
	_material = $VBoxContainer/CharacterPortrait.get_shader()
	
	$VBoxContainer/CharacterPortrait.flip(flip)
	
	await get_tree().process_frame
	

func _on_mouse_entered():
	_material.set_shader_parameter("index", 1)

func _on_mouse_exited():
	_material.set_shader_parameter("index", 0)
