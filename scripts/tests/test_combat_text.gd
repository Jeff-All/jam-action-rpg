extends MarginContainer

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed == false:
			$CombatText.show_combat_text(get_local_mouse_position(), "TEST")
