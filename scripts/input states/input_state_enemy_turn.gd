class_name EnemyTurnInputState

extends InputState

var character: Character
var target: Character

var next: Callable = _target

var timer: Timer:
	set(value):
		_timer = value
		_timer.timeout.connect(_on_timer)

var _timer: Timer

func begin():
	print("enemy_turn.begin")
	battle_board.reset()
	
	character.active = true
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
	var size = battle_board._pcs.size()
	var start_index = randi_range(0, size - 1)
	var index = 0
	while index < battle_board._pcs.size():
		if battle_board._pcs[(index + start_index) % size] != null:
			target = battle_board._pcs[index + start_index]
			break
		index += 1
	
	if target == null:
		print("no pcs to target")
		return
	
	target.highlight = true
	
	next = _damage
	_timer.start()

func _damage():
	print("damage")
	
	target.cur_health -= 3
	
	next = _end
	_timer.start()

func _end():
	print("end enemy turn")
	on_end_turn.emit()
