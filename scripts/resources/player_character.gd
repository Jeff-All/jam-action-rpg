class_name PlayerCharacter

extends Character

@export var character_class: Class:
	set(value):
		if _class != null && value != _class:
			_class.remove(self)
		_class = value
		_class.apply(self)

var _class: Class

@export var race: Race:
	set(value):
		if _race != null && value != race:
			_race.remove(self)
		_race = value
		_race.apply(self)

var _race: Race

func _get_actions() -> Array[Action]:
	return _race.actions + _class.actions
