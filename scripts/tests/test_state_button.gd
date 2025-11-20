extends MarginContainer


func _on_available_toggled(toggled_on):
	$CenterContainer/StateButton.available = toggled_on

func _on_active_toggled(toggled_on):
	$CenterContainer/StateButton.active = toggled_on
