class_name Trait

extends Resource

@export var name: String
@export var texture: Texture2D

func get_header() -> String:
	return name

func get_description() -> String:
	return ""

func _to_string() -> String:
	return name

func get_icon() -> Texture2D:
	return texture
