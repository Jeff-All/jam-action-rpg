extends MarginContainer

func _on_selected_toggled(toggled_on: bool):
	$CenterContainer/TurnOrderCharacter.selected = toggled_on
