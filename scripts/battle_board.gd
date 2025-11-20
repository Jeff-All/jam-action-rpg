class_name BattleBoard

extends PanelContainer

signal on_pc_pressed(character: CharacterUI, index: int)
signal on_pc_hover(character: CharacterUI)
signal on_pc_leave(character: CharacterUI)
signal on_enemy_pressed(character: CharacterUI, row: int, index: int)
signal on_enemy_hover(character: CharacterUI)
signal on_enemy_leave(character: CharacterUI)
signal on_action_pressed(action_button: ActionButton, index: int)

@export var ecounter: Encounter
var _pcs: Array[Character]
var _enemies: Array[Character]
var _characters: Array[Character]

var enemies: EncounterUI
var pcs: CharacterRow
var buttons: ButtonRow
var mid_text: MidText
var turn_order: TurnOrder

func _ready():
	enemies = $VBoxContainer/Top/EncounterUI
	pcs = $VBoxContainer/Bottom/PCs
	buttons = $VBoxContainer/Bottom/ButtonRow
	mid_text= $VBoxContainer/PanelContainer/MidText
	turn_order = $VBoxContainer/Top/TurnOrder
	reset()

func _on_pc_pressed(character: CharacterUI, index: int):
	on_pc_pressed.emit(character, index)

func _on_pc_hover(character: CharacterUI):
	on_pc_hover.emit(character)

func _on_pc_leave(character: CharacterUI):
	on_pc_leave.emit(character)

func _on_enemy_pressed(enemy: CharacterUI, row: int, column: int):
	on_enemy_pressed.emit(enemy, row, column)

func _on_enemy_hover(enemy: CharacterUI):
	on_enemy_hover.emit(enemy)

func _on_enemy_leave(enemy: CharacterUI):
	on_enemy_leave.emit(enemy)

func _on_action_button_pressed(action_button: ActionButton, index: int):
	on_action_pressed.emit(action_button, index)

func set_encounter(encounter: Encounter):
	enemies.set_encounter(encounter, $CharacterController)
	
	_enemies = enemies.get_enemies()

func set_pcs(pc_array: Array[BaseCharacter]):
	_pcs.clear()
	for index in pc_array.size():
		var cur_pc = pc_array[index]
		_pcs.append(null if cur_pc == null else $CharacterController.build_character(cur_pc))
	pcs.set_characters(_pcs)

func bind_actions(actions: Array[Action]):
	buttons.bind_actions(actions)

func reset():
	enemies.reset()
	pcs.reset()
	buttons.clear()
	mid_text.visible = false

func roll_initiative() -> TurnOrderCharacter:
	_characters = []
	for cur_enemy in _enemies:
		_characters.append(cur_enemy)
	for cur_pc in _pcs:
		if cur_pc != null:
			_characters.append(cur_pc)
	
	return turn_order.roll_initiative(_characters)

func _on_turn_order_mouse_enter(turn_order_character: TurnOrderCharacter):
	turn_order_character._character.turn_order_mouse_enter(turn_order_character)

func _on_turn_order_mouse_exit(turn_order_character: TurnOrderCharacter):
	turn_order_character._character.turn_order_mouse_exit(turn_order_character)
