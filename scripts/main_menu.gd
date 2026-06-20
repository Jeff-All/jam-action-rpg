class_name MainMenu

extends PanelContainer

signal on_campaigns_pressed()
signal on_options_pressed()
signal on_exit_pressed()

func _on_campaigns_pressed():
	on_campaigns_pressed.emit()

func _on_options_pressed():
	on_options_pressed.emit()

func _on_exit_pressed():
	on_exit_pressed.emit()
