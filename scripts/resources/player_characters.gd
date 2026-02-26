class_name PlayerCharacters

extends Resource

signal on_characters_dead
signal on_character_finished_cast(character: Character)

@export var characters: Array[PlayerCharacter]

func bind_player_characters():
	for cur_character in characters:
		bind_character(cur_character)

func bind_character(character: PlayerCharacter):
	character.on_death.connect(_on_character_death)
	character.on_finish_cast.connect(_on_character_finish_cast)

func _on_character_death(_character: Character):
	for cur_character in characters:
		if cur_character != null:
			if !cur_character.dead:
				return
	on_characters_dead.emit()

func _on_character_finish_cast(character: Character):
	on_character_finished_cast.emit(character)

func prepare_for_battle():
	for cur_character in characters:
		cur_character.prepare_for_battle()
