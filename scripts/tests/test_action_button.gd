extends MarginContainer

@export var action_a: Action
@export var action_b: Action


func _on_action_a_pressed():
	$"CenterContainer/Action Button".action = action_a

func _on_action_b_pressed():
	$"CenterContainer/Action Button".action = action_b

func _on_available_toggled(toggled_on):
	$"CenterContainer/Action Button".available = toggled_on

func _on_active_toggled(toggled_on):
	$"CenterContainer/Action Button".active = toggled_on
