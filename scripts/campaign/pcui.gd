class_name PCUI

extends Node

@export var flip: bool = false

var _material: ShaderMaterial
var portrait: CharacterPortrait
var _character: CharacterCampaign

var abilities: Array[AbilityButton]

var character: CharacterCampaign:
	set(value):
		_character = value
		portrait.character = value
		set_abilities()
	get: return _character

func _ready():
	_material = $VBoxContainer/CharacterPortrait.get_shader()
	portrait = $VBoxContainer/CharacterPortrait
	
	for cur in $VBoxContainer/PanelContainer/PanelContainer/MarginContainer/AbilityButtons.get_children():
		abilities.append(cur)
	
	portrait.flip(flip)
	
	await get_tree().process_frame

func _on_mouse_entered():
	_material.set_shader_parameter("index", 1)

func _on_mouse_exited():
	_material.set_shader_parameter("index", 0)

func set_abilities():
	clear_abilities()
	var index = 0
	for cur in _character.abilities:
		if index >= abilities.size():
			break
		abilities[index].ability = cur
		abilities[index].visible = cur != null
		index += 1

func clear_abilities():
	for cur in abilities:
		cur.visible = false
