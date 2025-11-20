class_name EncounterUI
extends VBoxContainer

signal on_enemy_pressed(enemy: CharacterUI, row: int, column: int)
signal on_enemy_hover(enemy: CharacterUI)
signal on_enemy_leave(enemy: CharacterUI)

var row_map: Dictionary[Character, int] = {}

func set_encounter(encounter: Encounter, character_controller: CharacterController):
	$"Bottom Row".clear()
	$"Top Row".clear()
	
	for index in encounter.front_row.size():
		var new_character = character_controller.build_character(encounter.front_row[index])
		row_map[new_character] = 0
		$"Bottom Row".set_character(index, new_character)

	for index in encounter.back_row.size():
		var new_character = character_controller.build_character(encounter.front_row[index])
		row_map[new_character] = 1
		$"Top Row".set_character(index, new_character)

func get_enemies() -> Array[Character]:
	var arr: Array[Character]
	for cur in row_map:
		arr.append(cur)
	return arr

func _on_character_ui_pressed(character: CharacterUI, index):
	on_enemy_pressed.emit(character, row_map[character.character], index)

func _on_character_hover(character: CharacterUI):
	on_enemy_hover.emit(character)

func _on_character_leave(character: CharacterUI):
	on_enemy_leave.emit(character)

func reset():
	$"Top Row".reset()
	$"Bottom Row".reset()

var _iter_index: int

func _iter_init(_iter):
	_iter_index = 0
	return 0 < $"Bottom Row".character_uis.size() + $"Top Row".character_uis.size()

func _iter_next(_iter):
	_iter_index += 1
	return _iter_index < $"Bottom Row".character_uis.size() + $"Top Row".character_uis.size()

func _iter_get(_iter):
	if _iter_index < $"Bottom Row".character_uis.size():
		return $"Bottom Row".character_uis[_iter_index]
	else:
		return $"Top Row".character_uis[_iter_index - $"Bottom Row".character_uis.size()]
