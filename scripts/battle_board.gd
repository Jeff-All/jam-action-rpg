class_name BattleBoard

extends PanelContainer

signal on_pc_pressed(character: CharacterUI, index: int)
signal on_pc_hover(character: CharacterUI)
signal on_pc_leave(character: CharacterUI)
signal on_enemy_pressed(character: CharacterUI, row: int, index: int)
signal on_enemy_hover(character: CharacterUI)
signal on_enemy_leave(character: CharacterUI)
signal on_action_pressed(action_button: ActionButton, index: int)
signal on_action_entered(action_button: ActionButton)
signal on_action_exited(action_button: ActionButton)
signal on_start_pressed()

@export var ecounter: Encounter
var _pcs: PlayerCharacters
var _enemies: Enemies

var enemies: EncounterUI
var pcs: CharacterRow
var mid_text: MidText
var start: Button
var combat_text: CombatText
var defend_row: ButtonRow
var tooltip: PanelContainer

func _ready():
	enemies = $VBoxContainer/Top/EncounterUI
	pcs = $VBoxContainer/Bottom/PCs
	mid_text= $VBoxContainer/PanelContainer/MidText
	start = $VBoxContainer/PanelContainer2/Start
	combat_text = $CombatText
	tooltip = $Tooltip
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
	_hide_tooltip()
	on_enemy_leave.emit(enemy)

func _on_action_button_pressed(action_button: ActionButton, index: int):
	on_action_pressed.emit(action_button, index)

func _on_action_button_entered(action_button: ActionButton):
	print("bb.action button entered")
	on_action_entered.emit(action_button)

func _on_action_button_exited(action_button: ActionButton):
	on_action_exited.emit(action_button)

func set_enemies(e: Enemies):
	enemies.set_encounter(e)
	_enemies = e

func set_pcs(player_characters: PlayerCharacters):
	_pcs = player_characters
	pcs.set_characters(_pcs.characters)
	pcs.set_combat_text(combat_text)

func reset():
	enemies.reset()
	pcs.reset()
	mid_text.visible = false
	start.visible = false

func _on_start_pressed():
	on_start_pressed.emit()

func _show_tooltip():
	tooltip.visible = true

func _hide_tooltip():
	tooltip.visible = false
