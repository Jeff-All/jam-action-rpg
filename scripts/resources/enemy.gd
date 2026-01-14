class_name Enemy

extends Character

@export var base: BaseEnemy

var threat_table: ThreatTable = ThreatTable.new()

func take_damage_from_player_character(pc: PlayerCharacter, damage: int):
	take_damage(damage)
	
	threat_table.adjust_threat(pc, damage)

func _get_name() -> String:
	return "%s.%s" % [base.name, base.count]

func setup_first_tick():
	pass

func process_tick(delta: float):
	if action_being_cast == null:
		start_cast(base.attack_action, threat_table.target) 
	super(delta)

func _get_actions() -> Array[Action]:
	return [base.attack_action]
