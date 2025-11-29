class_name Enemy

extends Character

@export var base: BaseEnemy

var threat_table: ThreatTable = ThreatTable.new()

func take_damage_from_player_character(pc: PlayerCharacter, damage: int):
	take_damage(damage)
	
	threat_table.adjust_threat(pc, damage)

func _get_name() -> String:
	return "%s.%s" % [base.name, base.count]
