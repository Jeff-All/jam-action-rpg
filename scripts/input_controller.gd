class_name InputController

extends Node

signal on_end_turn()
signal on_start_pressed()

var cur_state: InputState:
	set(value):
		if _cur_state != null:
			_cur_state.end()
		_cur_state = value
		if _cur_state != null:
			_cur_state.begin()

var _cur_state: InputState

var default_input_state: InputState = InputState.new()
var player_turn_input_state: PlayerTurnInputState = PlayerTurnInputState.new()
var enemy_turn_input_state: EnemyTurnInputState = EnemyTurnInputState.new()

func _ready():
	default_input_state.battle_board = $BattleBoard
	player_turn_input_state.battle_board = $BattleBoard
	enemy_turn_input_state.battle_board = $BattleBoard
	
	default_input_state.on_end_turn.connect(_on_end_turn)
	player_turn_input_state.on_end_turn.connect(_on_end_turn)
	enemy_turn_input_state.on_end_turn.connect(_on_end_turn)
	
	cur_state = default_input_state

func _on_end_turn():
	cur_state = null
	on_end_turn.emit()

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

func _on_action_button_pressed(action_button: ActionButton, index: int):
	_cur_state.on_action_button_pressed(action_button, index)

func to_default():
	cur_state = default_input_state

func to_player_turn(character: Character):
	player_turn_input_state.character = character
	cur_state = player_turn_input_state

func to_enemy_turn(character: Character):
	enemy_turn_input_state.character = character
	cur_state = enemy_turn_input_state

func _on_start_pressed():
	on_start_pressed.emit()
