class_name CharacterController

extends Control

var base_character_counts: Dictionary[BaseCharacter, int] = {}

func build_character(base_character: BaseCharacter) -> Character:
	if !base_character_counts.has(base_character):
		base_character_counts[base_character] = 0
	var cur_count = base_character_counts[base_character]
	base_character_counts[base_character] = cur_count + 1
	
	if base_character == null:
		print("NULL!!")
	
	return Character.new()
