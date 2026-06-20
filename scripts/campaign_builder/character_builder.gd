class_name CharacterBuilder

extends PanelContainer

signal on_slot_button_pressed(character_builder: CharacterBuilder, slot_button: SlotButton)

var buttons: Array[SlotButton]
var race: SlotButton
var _class: SlotButton
var ability: SlotButton
var _trait: SlotButton
var weapon: SlotButton
var armor: SlotButton

func _on_slot_button_pressed(slot_button: SlotButton):
	on_slot_button_pressed.emit(self, slot_button)

func _ready():
	for cur in find_children("*", "SlotButton", true):
		cur.on_pressed.connect(_on_slot_button_pressed)
		buttons.append(cur)
		match cur.category:
			"Race":
				race = cur
			"Class":
				_class = cur
			"Ability":
				ability = cur
			"Trait":
				_trait = cur
			"Weapon":
				weapon = cur
			"Armor":
				armor = cur

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

func build_character() -> CharacterBase:
	var character_base = CharacterBase.new()
	
	for cur_button in buttons:
		var cur_value = cur_button.value
		if cur_value is Race:
			character_base.race = cur_value
			continue
		if cur_value is Class:
			character_base.class_ = cur_value
			continue
		if cur_value is Ability:
			character_base.ability = cur_value
			continue
		if cur_value is Trait:
			character_base.trait_ = cur_value
			continue
		if cur_value is Weapon:
			character_base.weapon = cur_value
			continue
		if cur_value is Armor:
			character_base.armor = cur_value
			continue
	
	return character_base
