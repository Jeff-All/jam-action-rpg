class_name BattleSelector

extends PanelContainer

signal on_party_pressed

func _on_party_pressed(_simple_button):
	on_party_pressed.emit()
