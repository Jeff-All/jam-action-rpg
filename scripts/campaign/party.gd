class_name Party

extends PanelContainer

signal on_close_pressed()

var campaign: Campaign

var character_pane: CharacterPane
var left: SimpleButton
var right: SimpleButton
var selector: GridSelector

var cur_index: int

func _ready():
	character_pane = $MarginContainer/CharacterPane
	
	left = $MarginContainer/Left
	right = $MarginContainer/Right
	
	selector = $GridSelector
	
	selector.visible = false

func populate(_campaign: Campaign):
	campaign = _campaign
	character_pane.campaign = campaign
	
	left.visible = campaign.party.size() > 1
	right.visible = campaign.party.size() > 1
	
	populate_cur_character()

func populate_cur_character():
	var cur_character = campaign.party[cur_index]
	
	character_pane.character = cur_character

func _on_left_pressed(_simple_button):
	cur_index = posmod((cur_index - 1), campaign.party.size())
	
	populate_cur_character()

func _on_right_pressed(_simple_button):
	cur_index = (cur_index + 1) % campaign.party.size()
	
	populate_cur_character()

func _on_close_pressed(_simple_button):
	on_close_pressed.emit()

func _character_pane_on_armor_pressed():
	selector.fill(campaign.inventory.filter(func(value): return value is Armor), null)
	
	selector.visible = true

func _character_pane_on_weapon_pressed():
	selector.fill(campaign.inventory.filter(func(value): return value is Weapon), null)
	
	selector.visible = true

func _character_pane_on_ability_pressed(index: int):
	selector.fill(character_pane._character.available_abilities, character_pane._character.abilities[index] if index < 4 else null)
	
	selector.visible = true

func _grid_selector_on_selected(value):
	character_pane._grid_selector_on_selected(value)
	selector.visible = false
