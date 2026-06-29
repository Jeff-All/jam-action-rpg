class_name PartyBuilder

extends Control

signal on_finish(characters: Array[CharacterBase])
signal on_cancel()

@export var shadow_offsets: Dictionary[String, Vector2] = {
	"Race" = Vector2.ZERO,
	"Class" = Vector2.ZERO,
	"Ability" = Vector2.ZERO,
	"Trait" = Vector2.ZERO,
	"Weapon" = Vector2.ZERO,
	"Armor" = Vector2.ZERO,
}

var character_start_options: CharacterStartOptions

var builders: Array[CharacterBuilder]

var character_count: int

var grid_selector: GridSelector
var cancel: SimpleButton
var continue_: SimpleButton
var menu: SimpleButton

func _ready():
	grid_selector = $GridSelector
	cancel = $BorderButtons/Margin/BottomLeft/Cancel
	continue_ = $BorderButtons/Margin/BottomRight/Continue
	menu = $BorderButtons/Margin/TopLeft/Menu
	
	cancel.disabled = false
	cancel.disabled = false

	for cur in $Builders.get_children() :
		builders.append(cur)
		cur.visible = false

func start(_character_start_options: CharacterStartOptions):
	character_start_options = _character_start_options
	
	show_builders(character_start_options.character_count)

func hide_builders():
	for cur in builders:
		cur.visible = false

func show_builders(count: int):
	character_count = min(count, builders.size())
	hide_builders()
	var index = 0
	while index < character_count:
		builders[index].activate()
		index += 1
	continue_.disabled = !check_if_ready()

var cur_character_builder: CharacterBuilder
var cur_slot_button: SlotButton

func _on_slot_button_pressed(character_builder: CharacterBuilder, slot_button: SlotButton):
	print("party_builder._on_slot_button_pressed() %s" % slot_button.category)
	
	cur_character_builder = character_builder
	cur_slot_button = slot_button
	
	match slot_button.category:
		"Race":
			grid_selector.fill(character_start_options.races, character_builder.race.value, true, shadow_offsets["Race"])
		"Class":
			grid_selector.fill(character_start_options.classes, character_builder._class.value, true, shadow_offsets["Class"])
		"Ability":
			grid_selector.fill(character_start_options.abilities, character_builder.ability.value, true, shadow_offsets["Ability"])
		"Trait":
			grid_selector.fill(character_start_options.traits, character_builder._trait.value, true, shadow_offsets["Trait"])
		"Weapon":
			grid_selector.fill(character_start_options.weapons, character_builder.weapon.value, true, shadow_offsets["Weapon"])
		"Armor":
			grid_selector.fill(character_start_options.armor, character_builder.armor.value, true, shadow_offsets["Armor"])

func _on_grid_selector_selected(value):
	cur_slot_button.fill(value)
	continue_.disabled = !check_if_ready()

func check_if_ready() -> bool:
	for cur_index in character_count:
		if !builders[cur_index].check_if_ready():
			return false
	return true

func _on_cancel_pressed(_simple_button: SimpleButton):
	on_cancel.emit()

func _on_continue_pressed(_simple_button: SimpleButton):
	if check_if_ready():
		var characters: Array[CharacterBase]
		var cur_index = 0
		while cur_index < character_count:
			characters.append(builders[cur_index].build_character(cur_index))
			cur_index += 1
		on_finish.emit(characters)
