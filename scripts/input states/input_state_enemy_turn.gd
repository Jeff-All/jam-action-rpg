class_name EnemyTurnInputState

extends InputState

var enemy: Enemy
var target: PlayerCharacter

var next: Callable = _target

var timer: Timer:
	set(value):
		_timer = value
		_timer.timeout.connect(_on_timer)

var _timer: Timer

func begin():
	print("enemy_turn.begin")
	battle_board.reset()
	
	enemy.active = true
	next = _target
	
	_timer.start()

func end():
	print("enemy_turn.end")
	battle_board.reset()

func _on_timer():
	print("enemy_turn._on_timer")
	
	if next != null:
		next.call()
	
	print("no next")

func _target():
	target = enemy.threat_table.target
	
	target.highlight = true
	
	next = _damage
	_timer.start()

func _damage():
	print("damage")
	
	
	battle_board.combat_text.show_combat_text(battle_board.pcs.get_character_ui(target).center, "3")
	target.take_damage(3)
	
	next = _end
	_timer.start()

func _end():
	print("end enemy turn")
	on_end_turn.emit()
