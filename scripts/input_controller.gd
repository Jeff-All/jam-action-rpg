class_name InputController

extends Node

signal on_play_pressed()

var cur_state: InputState:
	set(value):
		if _cur_state != null:
			_cur_state.end()
		_cur_state = value
		if _cur_state != null:
			_cur_state.begin()

var _cur_state: InputState

var default_input_state: DefaultInputState = DefaultInputState.new()
var action_selected_input_state: ActionSelectedInputState = ActionSelectedInputState.new()

func _ready():
	default_input_state.battle_board = $BattleBoard
	action_selected_input_state.battle_board = $BattleBoard
	
	default_input_state.to_action_selected.connect(_to_action_selected)
	action_selected_input_state.on_target_selected.connect(to_default)
	
	cur_state = default_input_state

func _on_pc_pressed(character: CharacterUI, index: int):
	_cur_state._on_pc_pressed(character, index)

func _on_pc_hover(pc: CharacterUI):
	_cur_state.on_character_hover(pc)

func _on_pc_leave(pc: CharacterUI):
	_cur_state.on_character_leave(pc)

func _on_enemy_pressed(enemy: CharacterUI, row: int, col: int):
	_cur_state.on_enemy_pressed(enemy, row, col)

func _on_enemy_hover(enemy: CharacterUI):
	_cur_state.on_character_hover(enemy)

func _on_enemy_leave(enemy: CharacterUI):
	_cur_state.on_character_leave(enemy)

func _on_action_button_pressed(action_button: ActionButton):
	_cur_state.on_action_button_pressed(action_button)

func _on_action_button_entered(action_button: ActionButton):
	_cur_state.on_action_button_entered(action_button)

func _on_action_button_exited(action_button: ActionButton):
	_cur_state.on_action_button_exited(action_button)

func to_default():
	cur_state = default_input_state

func _to_action_selected(action_button: ActionButton):
	action_selected_input_state.action = action_button.action
	action_selected_input_state.character = action_button.character
	action_selected_input_state.action_button = action_button
	
	cur_state = action_selected_input_state

func _on_character_finished_cast(character: Character):
	_cur_state.on_character_finished_cast(character)


func _on_play_pressed():
	on_play_pressed.emit()
