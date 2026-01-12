class_name Enemy

extends Character

@export var base: BaseEnemy

var threat_table: ThreatTable = ThreatTable.new()

var last_attack: float

func take_damage_from_player_character(pc: PlayerCharacter, damage: int):
	take_damage(damage)
	
	threat_table.adjust_threat(pc, damage)

func _get_name() -> String:
	return "%s.%s" % [base.name, base.count]

func setup_first_tick():
	var half_attack_speed = base.attack_speed / 2
	last_attack = randf_range(half_attack_speed * -1, half_attack_speed)

func process_tick(delta: float):
	last_attack += delta
	
	if last_attack > base.attack_speed:
		_attack()
		last_attack = fmod(last_attack, base.attack_speed)

func _attack():
	var target = threat_table.target
	var dmg = 3
	target.take_damage(dmg)
