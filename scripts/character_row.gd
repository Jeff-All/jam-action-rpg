class_name CharacterRow

extends HBoxContainer

signal on_character_ui_pressed(character: CharacterUI, index: int)
signal on_character_hover(character: CharacterUI)
signal on_character_leave(character: CharacterUI)

var character_uis: Array[CharacterUI]
var character_map: Dictionary[Character, int] = {}

func _ready():
	for cur_character_ui: CharacterUI in get_children(false):
		cur_character_ui.visible = false
		character_uis.append(cur_character_ui)
		cur_character_ui.on_pressed.connect(_character_ui_pressed)
		cur_character_ui.on_hover.connect(_character_hovered)
		cur_character_ui.on_leave.connect(_character_leave)

func _character_ui_pressed(character: CharacterUI):
	on_character_ui_pressed.emit(character, character_map[character.character])

func _character_hovered(character: CharacterUI):
	on_character_hover.emit(character)

func _character_leave(character: CharacterUI):
	on_character_leave.emit(character)

func set_character(index: int, character: Character):
	if index < character_uis.size():
		if character != null:
			if character_map.has(character):
				var old_index = character_map[character]
				var old_character_ui = character_uis[old_index]
				old_character_ui.character = null
				old_character_ui.visible = false
			character_map[character] = index
			if character_uis[index].character != null:
				character_map.erase(character_uis[index].character)
			character_uis[index].character = character
			character_uis[index].visible = true
		else:
			character_uis[index].character = null
			character_uis[index].visible = false

func set_characters(characters: Array[Character]):
	clear()
	for index in characters.size():
		set_character(index, characters[index])

func clear():
	character_map = {}
	for cur_character_ui in character_uis:
		cur_character_ui.character = null
		cur_character_ui.visible = false

func get_character_ui(character: Character) -> CharacterUI:
	if character_map.has(character):
		return character_uis[character_map[character]]
	else: 
		return null

func reset():
	for cur_ui in character_uis:
		cur_ui.reset()

func get_characters() -> Array[Character]:
	var characters = [Character]
	for cur in character_map:
		characters.append(cur)
	return characters
