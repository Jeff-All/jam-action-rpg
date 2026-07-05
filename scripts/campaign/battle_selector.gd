
class_name BattleSelector

extends Control

signal on_party_pressed
signal on_start_battle_pressed(battle_options: BattleOptions)

var battle_preview: BattlePreview
var left: SimpleButton
var right: SimpleButton

var battles: Array[BattleOptions]

var cur_index: int

func _ready():
	battle_preview = $BattlePreview
	
	left = $BorderButtons/Margin/Left/Left
	right = $BorderButtons/Margin/Right/Right

func reset():
	battles = []
	cur_index = 0

func fill(_battles: Array[BattleOptions]):
	cur_index = 0
	battles = _battles
	show_cur_battle()
	if battles.size() > 1:
		left.visible = true
		right.visible = true

func show_cur_battle():
	battle_preview.fill(battles[cur_index])

func _on_party_pressed(_simple_button):
	on_party_pressed.emit()

func _on_left_pressed(_simple_button: SimpleButton):
	cur_index = posmod((cur_index - 1), battles.size())
	show_cur_battle()

func _on_right_pressed(_simple_button: SimpleButton):
	cur_index = (cur_index + 1) % battles.size()
	show_cur_battle()

func _on_start_battle_pressed(_simple_button: SimpleButton):
	on_start_battle_pressed.emit(battles[cur_index])
