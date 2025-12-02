class_name ThreatTableUI

extends HBoxContainer

var table: ThreatTable

var buttons: Array[ThreatTableCharacter] = []
var active_buttons: Array[ThreatTableCharacter] = []
var character_map: Dictionary[Character, int]

func _ready():
	print("_ready")
	for cur_child in get_children():
		print("_ready.add_child")
		cur_child.visible = false
		(cur_child as ThreatTableCharacter).on_death.connect(_on_death)
		buttons.append(cur_child as ThreatTableCharacter)
	print("_ready %s" % buttons.size())

func bind_table(_table: ThreatTable):
	table = _table
	
	print("bind_table %s" % buttons.size())
	
	for cur in table.table:
		print("bind_table %s" % cur.character.name)
		var button = buttons.pop_front()
		button.character = cur.character
		active_buttons.append(button)
		character_map[button._character] = active_buttons.size() - 1
	
	_order_buttons()
	
	_table.on_sort.connect(_order_buttons)

func _order_buttons():
	var new_array:Array[ThreatTableCharacter] = []
	
	for cur in table.table:
		var index = character_map[cur.character]
		var button = active_buttons[index]
		new_array.push_back(button)
		button.move_to_front()
		character_map[cur.character] = new_array.size() - 1
	
	active_buttons = new_array
	
	if expanded:
		expand()
	else:
		collapse()

var expanded: bool = false

func expand():
	expanded = true
	for cur in active_buttons:
		if cur._character != null:
			cur.visible = true
		else:
			print("cur.character is null")

func collapse():
	expanded = false
	for cur in active_buttons:
		cur.visible = false
	active_buttons[0].visible = true

func _on_mouse_entered() -> void:
	expand()

func _on_mouse_exited() -> void:
	collapse()

func _on_death(character: ThreatTableCharacter):
	character.visible = false
	
	table.sort_table()
