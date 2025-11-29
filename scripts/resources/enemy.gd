class_name Enemy

extends Character

@export var base: BaseEnemy

var threat_table: ThreatTable = ThreatTable.new()

func _get_name() -> String:
	return "%s.%s" % [base.name, base.count]
