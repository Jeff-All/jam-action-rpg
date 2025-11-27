class_name CharacterTextureGroup

extends Resource

@export var big: Texture2D
@export var small:Texture2D:
	get():
		var image = big.get_image()
		image.resize(50,50)
		var new_texture = ImageTexture.create_from_image(image)
		return new_texture
