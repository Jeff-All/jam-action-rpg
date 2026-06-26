class_name EnemyA

extends Character

@export var base: BaseEnemy

var threat_table: ThreatTable = ThreatTable.new()

var _actions: Array[ActionState]
var _attack_action: ActionState

func prepare_for_battle():
	super()
	_attack_action = ActionState.new(base.attack_action, self)
	_actions.append(_attack_action)


func take_damage(attacker: Character, damage: int):
	super(attacker, damage)
	
	threat_table.adjust_threat(attacker, damage)

func _get_name() -> String:
	return "%s.%s" % [base.name, base.count]

func setup_first_tick():
	pass

func process_tick(delta: float):
	if !dead && action_being_cast == null:
		start_cast(_attack_action, threat_table.target) 
	super(delta)

func _get_actions() -> Array[ActionState]:
	return _actions
