class_name Enemy

extends Character

@export var base: BaseEnemy

func _get_name() -> String:
	return "%s.%s" % [base.name, base.count]
