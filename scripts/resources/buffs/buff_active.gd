class_name BuffActive

extends Resource

var variables: Dictionary = {}

var base: BuffState
var caster: Character
var target: Character

func _init(_base: BuffState, _caster: Character, _target: Character):
	base = _base
	caster = _caster
	target = _target

func tick() -> bool:
	return base.base.tick(self, caster, target)

func end():
	base.base.end(self, caster, target)
