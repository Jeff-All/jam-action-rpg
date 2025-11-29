class_name ThreatTableUI

extends HBoxContainer

var table: ThreatTable

var buttons: Array[TurnOrderCharacter] = []
var character_map: Dictionary[Character, int]

func _ready():
	for cur_child in get_children():
		cur_child.visible = false
		buttons.append(cur_child as TurnOrderCharacter)
	
	buttons[0].visible = true

func bind_table(_table: ThreatTable):
	table = _table
	
	var index = 0
	for cur in table.table:
		buttons[index].character = cur.character
		character_map[cur.character] = index
		index += 1
	
	_order_buttons()

func _order_buttons():
	for cur in table.table:
		buttons[character_map[cur.character]].move_to_front()
	
	if expanded:
		expand()
	else:
		collapse()

var expanded: bool = false

func expand():
	expanded = true
	for cur in buttons:
		if cur._character != null:
			cur.visible = true
		else:
			print("cur.character is null")

func collapse():
	expanded = false
	for cur in buttons:
		cur.visible = false
	buttons[0].visible = true

func _on_mouse_entered() -> void:
	print("threat_table._on_mouse_entered")
	expand()

func _on_mouse_exited() -> void:
	print("threat_table._on_mouse_exited")
	collapse()
