class_name AbilitySelect

extends Control

signal on_select(ability: Ability)

var icon: TextureRect
var details: RichTextLabel
var label: Label

var _ability: Ability

var abiltity: Ability:
	set(value):
		_ability = value
		icon.texture = _ability.get_icon()
		label.text = _ability.name
		details.text = _ability.description
	get:
		return _ability

func _ready():
	icon = $Icon
	details = $Parchment/Details
	label = $TextureRect/Label

func _on_select_pressed():
	on_select.emit(_ability)
