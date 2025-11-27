class_name BasePlayerCharacters

extends Resource

@export var base_player_characters: Array[BasePlayerCharacter]

func build_player_characters() -> PlayerCharacters:
	var player_characters = PlayerCharacters.new()
	
	for cur_base in base_player_characters:
		player_characters.characters.append(cur_base.build_player_character())
	
	return player_characters
