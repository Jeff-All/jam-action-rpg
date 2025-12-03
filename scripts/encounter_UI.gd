class_name EncounterUI
extends VBoxContainer

signal on_enemy_pressed(enemy: CharacterUI, row: int, column: int)
signal on_enemy_hover(enemy: CharacterUI)
signal on_enemy_leave(enemy: CharacterUI)

var row_map: Dictionary[Enemy, int] = {}
var enemies: Enemies

func get_ui(enemy: Enemy):
	var row = row_map[enemy]
	match row:
		0: return $"Bottom Row".get_character_ui(enemy)
		1: return $"Top Row".get_character_ui(enemy)

func set_encounter(_enemies: Enemies):
	enemies = _enemies
	$"Bottom Row".clear()
	$"Top Row".clear()
	
	for index in enemies.front_row.size():
		var cur_character = enemies.front_row[index]
		row_map[cur_character] = 0
		$"Bottom Row".set_character(index, cur_character)
	
	for index in enemies.back_row.size():
		var cur_character = enemies.back_row[index]
		row_map[cur_character] = 1
		$"Top Row".set_character(index, cur_character)

func _on_character_ui_pressed(character: CharacterUI, index):
	on_enemy_pressed.emit(character, row_map[character.character as Enemy], index)

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
