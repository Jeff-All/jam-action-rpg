class_name CharacterPortrait

extends PanelContainer

var _character: CharacterCampaign
var view_port: SubViewport
var texture_rect: TextureRect

func _ready():
	print("ready")
	view_port = $MarginContainer/SubViewportContainer/SubViewport
	texture_rect = $TextureRect

var character: CharacterCampaign:
	set(value):
		_character = value
		_populate_textures()

func _populate_textures():
	$MarginContainer/Body.texture = _character.get_body()
	$MarginContainer/Head.texture = _character.get_head()

func get_shader() -> ShaderMaterial:
	return $MarginContainer/SubViewportContainer.material

func flip(value):
	$MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Body.flip_h = value
	$MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Head.flip_h = value
