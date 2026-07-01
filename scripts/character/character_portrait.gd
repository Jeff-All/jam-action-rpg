class_name CharacterPortrait

extends PanelContainer

var _character: CharacterCampaign
var view_port: SubViewport
var texture_rect: TextureRect
var body: TextureRect
var head: TextureRect

func _ready():
	view_port = $MarginContainer/SubViewportContainer/SubViewport
	texture_rect = $TextureRect
	body = $MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Body
	head = $MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Head

var character: CharacterCampaign:
	set(value):
		_character = value
		_populate_textures()

func _populate_textures():
	body.texture = _character.get_body()
	head.texture = _character.get_head()

func get_shader() -> ShaderMaterial:
	return $MarginContainer/SubViewportContainer.material

func flip(value):
	$MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Body.flip_h = value
	$MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Head.flip_h = value
