class_name LootUI

extends Control

signal on_item_selected(item: Resource)

var items: Array[ItemSelect]

func _ready():
	for cur in $Items.get_children():
		items.append(cur)

func setup(_items: Array[Resource]):
	for cur in items:
		cur.visible = false
	
	for cur in range(0, min(items.size(), _items.size())):
		items[cur].item = _items[cur]
		items[cur].visible = true

func _on_item_select(item):
	on_item_selected.emit(item)
