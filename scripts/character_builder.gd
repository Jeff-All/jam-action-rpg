class_name CharacterBuilder

extends PanelContainer

signal on_race_pressed(character_builder: CharacterBuilder)

func _on_race_pressed(_button: SlotButton):
	on_race_pressed.emit(self)

func activate(show_delete: bool = false):
	$MarginContainer/PanelContainer/MarginContainer/Character.visible = true
	$MarginContainer/PanelContainer/MarginContainer/Add.visible = false
	$MarginContainer/PanelContainer/MarginContainer/Character/Delete.visible = show_delete
	visible = true

func deactivate():
	$MarginContainer/PanelContainer/MarginContainer/Character.visible = false
	$MarginContainer/PanelContainer/MarginContainer/Add.visible = true
	visible = true
