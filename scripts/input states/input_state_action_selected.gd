class_name ActionSelectedInputState

extends DefaultInputState

signal on_target_selected()

var action: ActionState
var character: PlayerCharacter
var action_button: ActionButton

func begin():
	print("ActionSelected.begin")
	action_button.selected = true
	action_button.on_lock.connect(selected_action_button_locks)
	action.base.targeting.target(character, battle_board)

func end():
	print("ActionSelected.end")
	action_button.on_lock.disconnect(selected_action_button_locks)
	battle_board.reset()
	
func on_enemy_pressed(enemy: CharacterUI, row: int, col: int):
	print("ActionSelected.on_enemy_pressed(%s) at row %s and col %s" % [enemy.name, row, col])
	if action.base.can_afford(character):
		if action.base.instant:
			character.instant_cast(action, enemy.character)
		else :
			character.start_cast(action, enemy.character) 
		on_target_selected.emit()

func on_action_button_pressed(_action_button: ActionButton):
	print("default.on_action_button_pressed(%s)" % [action_button.action.base.name])
	if _action_button.character is PlayerCharacter:
		print("pressed PC action button")
		action = _action_button.action
		character = _action_button.character
		action_button.selected = false
		action_button.on_lock.disconnect(selected_action_button_locks)
		action_button = _action_button
		begin()

func selected_action_button_locks(_action_button: ActionButton):
	action_button.selected = false
	on_target_selected.emit()

func on_character_finished_cast(_character: Character):
	print("ActionSelected.on_character_finished_cast(%s)" % character.name)
	if _character == character && !action.base.can_afford(character):
		action_button.selected = false
		on_target_selected.emit()
