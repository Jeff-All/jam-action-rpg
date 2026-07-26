class_name Item

extends Resource

@export var name: String
@export var description: String
@export var texture: Texture2D

func get_header() -> String:
	return name

func get_description() -> String:
	return description

func _to_string() -> String:
	return name

func get_icon() -> Texture2D:
	return texture
