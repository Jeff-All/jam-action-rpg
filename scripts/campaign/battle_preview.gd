class_name BattlePreview

extends PanelContainer

var front_row: Array[EnemyPane]
var back_row: Array[EnemyPane]

func _ready():
	for cur in $MarginContainer/PanelContainer/VBoxContainer/BackRow.get_children():
		back_row.append(cur)
	
	for cur in $MarginContainer/PanelContainer/VBoxContainer/FrontRow.get_children():
		front_row.append(cur)

func fill(battle: BattleOptions):
	clear()
	
	var index = 0
	for cur in battle.front_row:
		if index > front_row.size():
			break
		front_row[index].enemy = cur
		front_row[index].visible = true
		index += 1
	index = 0
	for cur in battle.back_row: 
		if index > back_row.size():
			break
		back_row[index].enemy = cur
		back_row[index].visible = true
		index += 1

func clear():
	for cur in front_row:
		cur.visible = false
	for cur in back_row:
		cur.visible = false
