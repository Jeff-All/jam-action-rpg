class_name BattleSelector

extends PanelContainer

signal on_party_pressed

var battle_preview: BattlePreview
var left: SimpleButton
var right: SimpleButton

var battles: Array[BattleOptions]

var cur_index: int

func _ready():
	battle_preview = $MarginContainer/BattlePreview
	
	left = $MarginContainer2/Left
	right = $MarginContainer2/Right

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
