class_name CharacterPortrait

extends PanelContainer

var _character: CharacterCampaign
var view_port: SubViewport
var texture_rect: TextureRect
var body: TextureRect
var head: TextureRect
var animation_player: AnimationPlayer

func _ready():
	view_port = $MarginContainer/SubViewportContainer/SubViewport
	texture_rect = $TextureRect
	body = $MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Control/Body
	head = $MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Control/Head
	animation_player = $AnimationPlayer

var character: CharacterCampaign:
	set(value):
		_character = value
		_populate_textures()

func _populate_textures():
	if _character != null:
		body.texture = _character.get_body()
		head.texture = _character.get_head()
	else:
		body.texture = null
		head.texture = null

func get_shader() -> ShaderMaterial:
	return $MarginContainer/SubViewportContainer.material

func flip(value):
	$MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Control/Body.flip_h = value
	$MarginContainer/SubViewportContainer/SubViewport/MarginContainer/Control/Head.flip_h = value
