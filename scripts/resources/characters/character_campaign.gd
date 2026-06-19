class_name CharacterCampaign

extends Resource

var base

func _init(_base):
	base = _base

func get_character_battle() -> CharacterBattle:
	return CharacterBattle.new(self)
