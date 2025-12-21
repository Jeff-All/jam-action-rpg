class_name PlayerTurnInputState

extends InputState

var character: Character
var selected_action: ActionButton

func begin():
	print("player_turn.begin")
	battle_board.reset()
	var cur_character_ui = battle_board.pcs.get_character_ui(character)
	if character == null:
		push_error("character is null")
	if cur_character_ui == null:
		push_error("character %s is not present in PCs" % character.name)
	character.active = true
	#battle_board.pcs.get_character_ui(character).active = true
	battle_board.bind_actions(character, character.actions)

func end():
	print("player_turn.end")
	battle_board.reset()

func on_character_hover(_character: CharacterUI):
	print("player_turn._on_character_hover(%s)" % _character.character.name)
	selected_action.action.on_hover_target(character, _character, battle_board)

func on_character_leave(_character: CharacterUI):
	print("player_turn._on_character_leave(%s)" % _character.character.name)
	selected_action.action.on_leave_target(character, _character, battle_board)

func _on_pc_pressed(pc: CharacterUI, index: int):
	print("player_turn.on_pcs_character_ui_pressed(%s) at %s" % [pc.name, index])
	if selected_action.action.on_pressed_target(character, pc, battle_board):
		on_end_turn.emit()

func on_enemy_pressed(enemy: CharacterUI, row: int, col: int):
	print("player_turn.on_enemy_pressed(%s) at row %s and col %s" % [enemy.name, row, col])
	if selected_action.action.on_pressed_target(character, enemy, battle_board):
		on_end_turn.emit()

func on_action_button_pressed(action_button: ActionButton, index:int):
	print("player_turn.on_action_button_pressed(%s) at index %s" % [action_button.action.name, index])
	if action_button.action != selected_action:
		if selected_action != null:
			selected_action.selected = false
		selected_action = action_button
		selected_action.selected = true
		selected_action.action.targeting.target(character, battle_board)

func on_action_button_entered(action_button: ActionButton):
	print("player_turn.on_action_button_entered(%s)" % action_button.action.name)
	action_button.action.render_tooltip(character, battle_board.tooltip)
	battle_board._show_tooltip()

func on_action_button_exited(action_button: ActionButton):
	print("player_turn.on_action_button_exited(%s)" % action_button.action.name)
	battle_board._hide_tooltip()
