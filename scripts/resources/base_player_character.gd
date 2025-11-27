class_name BasePlayerCharacter

extends Resource

@export var character_class: Class
@export var race: Race
@export var texture: Texture2D

func build_player_character() -> PlayerCharacter:
	var player_character = PlayerCharacter.new()
	
	player_character.character_class = character_class
	player_character.race = race
	player_character.texture = texture
	
	return player_character
