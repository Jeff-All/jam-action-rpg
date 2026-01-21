class_name ActionButtonGrid

extends VBoxContainer

signal on_action_button_pressed(action_button: ActionButton)
signal on_action_button_entered(action_button: ActionButton)
signal on_action_button_exited(action_button: ActionButton)

var top_row: ButtonRow
var bottom_row: ButtonRow

@export var row_count = 5

var _is_ready: bool = false

func _ready():
	top_row = $TopRow
	bottom_row = $BottomRow

var selectable: bool:
	set(value):
		$TopRow.selectable = value
		$BottomRow.selectable = value

func bind_actions(character: Character):
	if character.actions.size() <= 0: return
	top_row.bind_actions(character, character.actions.slice(0, min(row_count, character.actions.size())))
	
	if character.actions.size() > row_count:
		bottom_row.bind_actions(character, character.actions.slice(row_count, min(row_count * 2, character.actions.size())))

func _on_action_button_pressed(action_button: ActionButton):
	on_action_button_pressed.emit(action_button)

func _on_action_button_entered(action_button: ActionButton):
	on_action_button_entered.emit(action_button)

func _on_action_button_exited(action_button: ActionButton):
	on_action_button_exited.emit(action_button)

func reset():
	top_row.reset()
	bottom_row.reset()

func lock():
	top_row.lock()
	bottom_row.lock()
