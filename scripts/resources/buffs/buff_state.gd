class_name BuffState

extends Resource

var base: Buff

func _init(_base: Buff):
	base = _base

func new_active(caster: Character, target: Character) -> BuffActive:
	return base.new_active(self, caster, target)
