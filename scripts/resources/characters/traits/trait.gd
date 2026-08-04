class_name Trait

extends Resource

@export var name: String
@export var texture: Texture2D

@export var attributes: Dictionary[CharacterCampaign.Attributes, float]
@export var resources: Dictionary[CharacterCampaign.Resources, float]

func get_header() -> String:
	return name

func get_description() -> String:
	return ""

func _to_string() -> String:
	return name

func get_icon() -> Texture2D:
	return texture

func apply(pcui: PCUI, _battle: Battle):
	for cur in attributes:
		pcui.character.attributes[cur].add_adjustment(self, attributes[cur])
	
	for cur in resources:
		pcui.character.resources[cur].add_adjustment(self, resources[cur])

func remove(pcui: PCUI):
	for cur in attributes:
		pcui.character.attributes[cur].remove_adjustment(self)
	
	for cur in resources:
		pcui.character.resources[cur].remove_adjustment(self)
