class_name PlayerCharacter

extends Character

@export var character_class: Class:
	set(value):
		if _class != null && value != _class:
			_class.remove(self)
		_class = value

var _class: Class

@export var race: Race

func _get_actions() -> Array[Action]:
	return race.actions + _class.actions
