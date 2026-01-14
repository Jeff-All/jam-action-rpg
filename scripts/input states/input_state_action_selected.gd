class_name ActionSelectedInputState

extends DefaultInputState

signal on_target_selected()

var action: Action
var character: PlayerCharacter
var action_button: ActionButton

func begin():
	print("ActionSelected.begin")
	action_button.selected = true
	action.targeting.target(character, battle_board)

func end():
	print("ActionSelected.end")
	battle_board.reset()
	
func on_enemy_pressed(enemy: CharacterUI, row: int, col: int):
	print("ActionSelected.on_enemy_pressed(%s) at row %s and col %s" % [enemy.name, row, col])
	character.start_cast(action, enemy.character) 
	on_target_selected.emit()
