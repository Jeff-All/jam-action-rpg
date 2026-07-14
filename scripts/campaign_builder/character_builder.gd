class_name CharacterBuilder

extends Control

signal on_slot_button_pressed(character_builder: CharacterBuilder, slot_button: SlotButton)

var buttons: Array[SlotButton]
var race: SlotButton
var _class: SlotButton
var ability: SlotButton
var _trait: SlotButton
var weapon: SlotButton
var armor: SlotButton

var character_options: CharacterStartOptions

func _on_slot_button_pressed(slot_button: SlotButton):
	on_slot_button_pressed.emit(self, slot_button)

func _ready():
	for cur in find_children("*", "SlotButton", true):
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

func set_defaults():
	pass

func activate(_character_options: CharacterStartOptions):
	character_options = _character_options
	
	race.fill(character_options.races[0])
	_class.fill(character_options.classes[0])
	ability.fill(character_options.abilities[0])
	_trait.fill(character_options.traits[0])
	weapon.fill(character_options.weapons[0])
	armor.fill(character_options.armor[0])
	
	visible = true

func deactivate():
	visible = false

func check_if_ready() -> bool:
	for cur in buttons:
		if !cur.locked && cur.value == null:
			return false
	return true

func build_character(index: int) -> CharacterBase:
	var character_base = CharacterBase.new(index)
	
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
