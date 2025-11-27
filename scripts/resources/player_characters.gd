class_name PlayerCharacters

extends Resource

signal on_characters_dead

@export var characters: Array[PlayerCharacter]

func bind_player_characters():
	for cur_character in characters:
		bind_character(cur_character)

func bind_character(character: PlayerCharacter):
	character.on_death.connect(_on_character_death)

func _on_character_death(_character: Character):
	for cur_character in characters:
		if cur_character != null:
			if !cur_character.dead:
				return
	on_characters_dead.emit()
