class_name BattleBoard

extends PanelContainer

signal on_pc_pressed(character: CharacterUI, index: int)
signal on_pc_hover(character: CharacterUI)
signal on_pc_leave(character: CharacterUI)
signal on_enemy_pressed(character: CharacterUI, row: int, index: int)
signal on_enemy_hover(character: CharacterUI)
signal on_enemy_leave(character: CharacterUI)
signal on_action_pressed(action_button: ActionButton, index: int)
signal on_start_pressed()

@export var ecounter: Encounter
var _pcs: PlayerCharacters
var _enemies: Enemies

var enemies: EncounterUI
var pcs: CharacterRow
var buttons: ButtonRow
var mid_text: MidText
var turn_order: TurnOrder
var start: Button
var combat_text: CombatText

func _ready():
	enemies = $VBoxContainer/Top/EncounterUI
	pcs = $VBoxContainer/Bottom/PCs
	buttons = $VBoxContainer/Bottom/ButtonRow
	mid_text= $VBoxContainer/PanelContainer/MidText
	turn_order = $VBoxContainer/Top/TurnOrder
	start = $VBoxContainer/PanelContainer/Start
	combat_text = $CombatText
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

func set_enemies(e: Enemies):
	enemies.set_encounter(e)
	_enemies = e

func set_pcs(player_characters: PlayerCharacters):
	_pcs = player_characters
	pcs.set_characters(_pcs.characters)

func bind_actions(character: Character, actions: Array[Action]):
	buttons.bind_actions(character, actions)

func reset():
	enemies.reset()
	pcs.reset()
	buttons.clear()
	mid_text.visible = false
	start.visible = false

func roll_initiative() -> TurnOrderCharacter:
	return turn_order.roll_initiative(_enemies.all + _pcs.characters)

func _on_turn_order_mouse_enter(turn_order_character: TurnOrderCharacter):
	turn_order_character._character.turn_order_mouse_enter(turn_order_character)

func _on_turn_order_mouse_exit(turn_order_character: TurnOrderCharacter):
	turn_order_character._character.turn_order_mouse_exit(turn_order_character)

func _on_start_pressed():
	on_start_pressed.emit()
