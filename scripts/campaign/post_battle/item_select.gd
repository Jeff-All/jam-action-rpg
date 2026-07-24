class_name ItemSelect

extends Control

signal on_select(item: Resource)

var icon: TextureRect
var details: RichTextLabel
var label: Label

var _item: Resource

var item: Resource:
	set(value):
		_item = value
		icon.texture = _item.get_icon()
		label.text = _item.name
		#details.text = _item.description
	get:
		return _item

func _ready():
	icon = $Icon
	details = $Parchment/Details
	label = $TextureRect/Label

func _on_select_pressed():
	on_select.emit(_item)
