class_name SelectorPane

extends Control

signal on_select(val)

var icon: TextureRect
var details: RichTextLabel
var label: Label

var _value

var value:
	set(v):
		_value = v
		icon.texture = _value.get_icon()
		label.text = _value.get_header()
		details.text = _value.get_description()
	get:
		return _value

func _ready():
	icon = $Icon
	details = $Parchment/Details
	label = $TextureRect/Label

func _on_select_pressed():
	on_select.emit(_value)
