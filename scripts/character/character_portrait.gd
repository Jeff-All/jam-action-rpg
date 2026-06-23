class_name CharacterPortrait

extends PanelContainer

var _character: CharacterCampaign

var character: CharacterCampaign:
	set(value):
		_character = value
		_populate_textures()

func _populate_textures():
	$MarginContainer/Body.texture = _character.get_body()
	$MarginContainer/Head.texture = _character.get_head()
