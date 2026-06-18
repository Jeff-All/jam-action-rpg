extends PanelContainer

signal on_finish(characters: Array[Character])
signal on_cancel()

var character_start_options: CharacterStartOptions

var builders: Array[CharacterBuilder]

var character_count: int

func _ready():
	$GridSelector.on_selected.connect(_on_grid_selector_selected)
	
	$MarginContainer/VBoxContainer/buttons/Cancel.disabled = false
	$MarginContainer/VBoxContainer/buttons/Continue.disabled = false

	for cur in $MarginContainer/VBoxContainer/HBoxContainer.get_children() :
		builders.append(cur)
		cur.visible = false
		cur.on_slot_button_pressed.connect(_on_slot_button_pressed)

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
	$MarginContainer/VBoxContainer/buttons/Continue.disabled = !check_if_ready()

var cur_character_builder: CharacterBuilder
var cur_slot_button: SlotButton

func _on_slot_button_pressed(character_builder: CharacterBuilder, slot_button: SlotButton):
	print("party_builder._on_slot_button_pressed() %s" % slot_button.category)
	
	cur_character_builder = character_builder
	cur_slot_button = slot_button
	
	match slot_button.category:
		"Race":
			$GridSelector.fill(character_start_options.races, true)
		"Class":
			$GridSelector.fill(character_start_options.classes, true)
		"Ability":
			$GridSelector.fill(character_start_options.abilities, true)
		"Trait":
			$GridSelector.fill(character_start_options.traits, true)
		"Weapon":
			$GridSelector.fill(character_start_options.weapons, true)
		"Armor":
			$GridSelector.fill(character_start_options.armor, true)

func _on_grid_selector_selected(value):
	cur_slot_button.fill(value)
	$MarginContainer/VBoxContainer/buttons/Continue.disabled = !check_if_ready()

func check_if_ready() -> bool:
	for cur_index in character_count:
		if !builders[cur_index].check_if_ready():
			return false
	return true

func _on_cancel_pressed(simple_button: SimpleButton):
	on_cancel.emit()

func _on_continue_pressed(simple_button: SimpleButton):
	if check_if_ready():
		var characters: Array[Character]
		for cur in builders:
			characters.append(cur.build_character())
		on_finish.emit()
