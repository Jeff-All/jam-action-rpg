class_name EnemyTurnInputState

extends InputState


var character: Character

var timer: Timer:
	set(value):
		_timer = value
		_timer.timeout.connect(_on_timer)

var _timer: Timer

func begin():
	print("enemy_turn.begin")
	battle_board.reset()
	
	character.active = true
	
	_timer.start()

func end():
	print("enemy_turn.end")
	battle_board.reset()

func _on_timer():
	print("enemy_turn._on_timer")
	on_end_turn.emit()
