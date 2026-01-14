class_name InputState

extends Node

@warning_ignore("unused_signal")
signal on_end_turn()

@export var battle_board: BattleBoard

func begin():
	print("default.begin")

func end():
	print("default.end")

func _on_pc_pressed(pc: CharacterUI, index: int):
	print("default.on_pcs_character_ui_pressed(%s) at %s" % [pc.name, index])

func on_enemy_pressed(enemy: CharacterUI, row: int, col: int):
	print("default.on_enemy_pressed(%s) at row %s and col %s" % [enemy.name, row, col])

func on_character_hover(character: CharacterUI):
	print("default.on_character_hovered(%s)" % character.character.name)

func on_character_leave(character: CharacterUI):
	print("default.on_character_leave(%s)" % character.character.name)

func on_action_button_pressed(action_button: ActionButton):
	print("default.on_action_button_pressed(%s)" % [action_button.action.name])
	if action_button.character is PlayerCharacter:
		print("pressed PC action button")

func on_action_button_entered(action_button: ActionButton):
	print("default.on_action_button_entered(%s)" % action_button.action.name)
	action_button.action.render_tooltip(action_button.character, battle_board.tooltip)
	battle_board._show_tooltip()

func on_action_button_exited(action_button: ActionButton):
	print("default.on_action_button_exited(%s)" % action_button.action.name)
	battle_board._hide_tooltip()
