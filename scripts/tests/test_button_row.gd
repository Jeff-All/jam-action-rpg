extends MarginContainer

@export var action_set_a: Array[Action]
@export var action_set_b: Array[Action]

func _on_action_set_a_pressed():
	$CenterContainer/ButtonRow.bind_actions(action_set_a)

func _on_action_set_b_pressed():
	$CenterContainer/ButtonRow.bind_actions(action_set_b)


func _on_action_button_pressed(action_button, index):
	print("_on_action_button_pressed(%s, %s)" % [action_button.action.name, index])
