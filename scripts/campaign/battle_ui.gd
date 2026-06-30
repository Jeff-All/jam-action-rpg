class_name BattleUI

extends Control

var front_row: Array[EnemyUI]
var back_row: Array[EnemyUI]

var pcs: Array[PCUI]

var battle: Battle

func _ready():
	for cur in $Foreground/VBoxContainer2/Enemies/FrontRow.get_children():
		front_row.append(cur)
	
	for cur in $Foreground/VBoxContainer2/Enemies/BackRow.get_children():
		back_row.append(cur)
	
	for cur in $Foreground/VBoxContainer2/PCs.get_children():
		pcs.append(cur)

func setup_battle(_battle: Battle):
	battle = _battle
	setup_enemies()
	setup_party()

func setup_enemies():
	hide_enemies()
	setup_enemy_row(front_row, battle.front_row)
	setup_enemy_row(back_row, battle.back_row)

func hide_enemies():
	for cur in front_row:
		cur.visible = false
	for cur in back_row:
		cur.visible = false

func setup_enemy_row(row: Array[EnemyUI], enemies: Array[EnemyBattle]):
	var index = 0
	for cur in enemies: 
		if index >= row.size():
			break
		row[index].enemy = cur
		row[index].visible = true
		index += 1

func setup_party():
	hide_pcs()
	var index = 0
	for cur in battle.party:
		if index > pcs.size():
			break
		pcs[index].character = cur
		pcs[index].visible = true
		index += 1

func hide_pcs():
	for cur in pcs:
		cur.visible = false
