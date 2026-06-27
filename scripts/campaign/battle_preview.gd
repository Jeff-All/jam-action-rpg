class_name BattlePreview

extends Control

var front_row: HBoxContainer
var back_row: HBoxContainer

func _ready():
	front_row = $FrontRow
	back_row = $BackRow

func fill(battle: BattleOptions):
	clear()
	
	if battle.front_row.size() > 0:
		fill_row(front_row, battle.front_row)
		if battle.back_row.size() > 0:
			fill_row(back_row, battle.back_row)
	else: if battle.back_row.size() > 0:
		fill_row(front_row, battle.back_row)

func fill_row(row: HBoxContainer, enemies: Array[Enemy]):
	var index = 0
	for cur in row.get_children():
		if index >= enemies.size():
			return
		cur.enemy = enemies[index]
		cur.visible = true
		index += 1

func clear():
	clear_row(front_row)
	clear_row(back_row)

func clear_row(row: HBoxContainer):
	for cur in row.get_children():
		cur.visible = false
