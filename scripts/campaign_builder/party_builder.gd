class_name PartyBuilder

extends PanelContainer

signal on_finish(characters: Array[CharacterBase])
signal on_cancel()

var character_start_options: CharacterStartOptions

var builders: Array[CharacterBuilder]

var character_count: int

func _ready():
	$GridSelector.on_selected.connect(_on_grid_selector_selected)
	
	$MarginContainer/Footer/Cancel.disabled = false
	$MarginContainer/Footer/Continue.disabled = false

	for cur in $MarginContainer/Builders.get_children() :
		builders.append(cur)
		cur.visible = false
		cur.on_slot_button_pressed.connect(_on_slot_button_pressed)

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
	$MarginContainer/Footer/Continue.disabled = !check_if_ready()

var cur_character_builder: CharacterBuilder
var cur_slot_button: SlotButton

func _on_slot_button_pressed(character_builder: CharacterBuilder, slot_button: SlotButton):
	print("party_builder._on_slot_button_pressed() %s" % slot_button.category)
	
	cur_character_builder = character_builder
	cur_slot_button = slot_button
	
	match slot_button.category:
		"Race":
			$GridSelector.fill(character_start_options.races, character_builder.race.value, true)
		"Class":
			$GridSelector.fill(character_start_options.classes, character_builder._class.value, true)
		"Ability":
			$GridSelector.fill(character_start_options.abilities, character_builder.ability.value, true)
		"Trait":
			$GridSelector.fill(character_start_options.traits, character_builder._trait.value, true)
		"Weapon":
			$GridSelector.fill(character_start_options.weapons, character_builder.weapon.value, true)
		"Armor":
			$GridSelector.fill(character_start_options.armor, character_builder.armor.value, true)

func _on_grid_selector_selected(value):
	cur_slot_button.fill(value)
	$MarginContainer/Footer/Continue.disabled = !check_if_ready()

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
			characters.append(builders[cur_index].build_character())
			cur_index += 1
		on_finish.emit(characters)
