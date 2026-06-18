class_name CharacterBuilder

extends PanelContainer

signal on_slot_button_pressed(character_builder: CharacterBuilder, slot_button: SlotButton)

var buttons: Array[SlotButton]

func _on_slot_button_pressed(slot_button: SlotButton):
	on_slot_button_pressed.emit(self, slot_button)

func _ready():
	for cur in find_children("*", "SlotButton", true):
		cur.on_pressed.connect(_on_slot_button_pressed)
		buttons.append(cur)

func activate(show_delete: bool = false):
	$MarginContainer/PanelContainer/MarginContainer/Character.visible = true
	$MarginContainer/PanelContainer/MarginContainer/Add.visible = false
	$MarginContainer/PanelContainer/MarginContainer/Character/Delete.visible = show_delete
	visible = true

func deactivate():
	$MarginContainer/PanelContainer/MarginContainer/Character.visible = false
	$MarginContainer/PanelContainer/MarginContainer/Add.visible = true
	visible = true

func check_if_ready() -> bool:
	for cur in buttons:
		if !cur.locked && cur.value == null:
			return false
	return true

func build_character() -> Character:
	var character = Character.new()
	
	for cur_button in buttons:
		cur_button.value.apply(character)
	
	return character
