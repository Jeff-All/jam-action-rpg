class_name CharacterPane

extends Control

signal on_weapon_pressed
signal on_armor_pressed
signal on_ability_pressed(index: int)
signal on_trait_pressed(index: int)

var campaign: Campaign
var _character: CharacterCampaign

var character: CharacterCampaign:
	set(value):
		_character = value
		populate()

var level_up: SimpleButton
var portrait: CharacterPortrait

var race: SlotButton
var _class: SlotButton
var weapon: SlotButton
var armor: SlotButton

var keybinds: Array[TextureRect]
var abilities: Array[SlotButton]
var traits: Array[SlotButton]

func _ready():
	level_up = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/CharacterPortrait/LevelUp
	portrait = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/CharacterPortrait
	
	race = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/PanelContainer4/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer2/VBoxContainer4/Race
	_class = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/PanelContainer4/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer2/VBoxContainer3/Class
	weapon = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/PanelContainer4/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer2/VBoxContainer/Weapon
	armor = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/PanelContainer4/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer2/VBoxContainer2/Armor
	
	race.locked = true
	_class.locked = true
	
	for cur in $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/PanelContainer2/MarginContainer/VBoxContainer/PanelContainer/Abilities.find_children("Keybind*"):
		keybinds.append(cur)
	
	for cur in $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/PanelContainer2/MarginContainer/VBoxContainer/PanelContainer/Abilities.get_children():
		abilities.append(cur)
	
	for cur in $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/PanelContainer5/MarginContainer/VBoxContainer/PanelContainer/Traits.get_children():
		traits.append(cur)
	
	level_up.visible = false

func populate():
	portrait.character = _character
	
	race.fill(_character.race)
	_class.fill(_character._class)
	weapon.fill(_character.weapon)
	armor.fill(_character.armor)
	
	populate_button_row(abilities, _character.abilities)
	populate_button_row(traits, _character.traits)
	
	var index = 0
	for cur in _character.get_keybinds():
		if index >= keybinds.size():
			break
		keybinds[index].texture = Global.action_button_art_map[cur]
		index += 1

func populate_button_row(buttons, values):
	var index = 0
	for cur in values:
		if index >= buttons.size():
			return
		buttons[index].fill(cur)
		index += 1

var cur_slot_button: SlotButton

func _on_weapon_pressed(slot_button: SlotButton):
	cur_slot_button = slot_button
	on_weapon_pressed.emit()

func _on_armor_pressed(slot_button: SlotButton):
	cur_slot_button = slot_button
	on_armor_pressed.emit()

var cur_index: int

func _on_ability_pressed(slot_button: SlotButton, index: int):
	cur_slot_button = slot_button
	cur_index = index
	on_ability_pressed.emit(index)

func _on_trait_pressed(slot_button: SlotButton, index: int):
	cur_slot_button = slot_button
	cur_index = index
	on_trait_pressed.emit(index)

func _grid_selector_on_selected(value):
	match cur_slot_button.category:
		"armor":
			swap_armor(value as Armor)
		"weapon":
			swap_weapon(value as Weapon)
		"ability":
			swap_ability(value as Ability)
		"trait":
			swap_trait(value as Trait)

func swap_armor(_armor: Armor):
	var old_armor = cur_slot_button.value
	cur_slot_button.fill(_armor)
	_character.unequip_armor()
	_character.equip_armor(_armor)
	portrait._populate_textures()
	campaign.inventory.remove_at(campaign.inventory.find(_armor))
	campaign.inventory.append(old_armor)

func swap_weapon(_weapon: Weapon):
	var old_weapon = cur_slot_button.value
	cur_slot_button.fill(_weapon)
	_character.unequip_weapon()
	_character.equip_weapon(_weapon)
	portrait._populate_textures()
	campaign.inventory.remove_at(campaign.inventory.find(_weapon))
	campaign.inventory.append(old_weapon)

func swap_ability(_ability: Ability):
	var old_button_index = _character.abilities.find(_ability)
	var old_ability = cur_slot_button.value
	_character.abilities[cur_index] = _ability
	if old_button_index >= 0 && _ability != null:
		_character.abilities[old_button_index] = old_ability
	populate_button_row(abilities, _character.abilities)

func swap_trait(_trait: Trait):
	var old_button_index = _character.traits.find(_trait)
	var old_trait = cur_slot_button.value
	_character.traits[cur_index] = _trait
	if old_button_index >= 0 && _trait != null:
		_character.traits[old_button_index] = old_trait
	_character.traits = _character.traits.filter(func(value): return value != null)
	_character.traits.resize(4)
	populate_button_row(traits, _character.traits)
