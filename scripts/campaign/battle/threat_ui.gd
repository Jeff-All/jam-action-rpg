class_name ThreatUI

extends MarginContainer

@export var min_seperation: float
@export var overlap_seperation: float

var table: ThreatTable

var pc_displays: Array[PCDisplay]
var display_map: Dictionary[PCUI, PCDisplay]

func _ready():
	for cur in $Control/Panel2/Panel.get_children():
		pc_displays.append(cur)

func reset():
	if table != null:
		table.on_threat_change.disconnect(_on_threat_change)
	reset_displays()
	display_map.clear()

func reset_displays():
	for cur in pc_displays:
		cur.visible = false

func bind_table(threat_table: ThreatTable):
	threat_table.on_threat_change.connect(_on_threat_change)
	table = threat_table
	reset_displays()
	display_map.clear()
	var index = 0
	for cur in threat_table.table:
		display_map[cur] = pc_displays[index]
		pc_displays[index].texture_rect.texture = cur.texture
		pc_displays[index].visible = true
		index += 1
		if index >= pc_displays.size():
			break
	update_order()

func update_order():
	var sorted = table.table.keys()
	sorted.sort_custom(func(a,b): return table.table[a] < table.table[b])
	
	var width = table.threat_width
	
	for cur in sorted:
		var pos = table.table[cur] / width
		display_map[cur].anchor_left = pos
		display_map[cur].anchor_right = pos

func _on_threat_change(_target: PCUI):
	update_order()
