class_name ChronoController

extends Node

var enemies: Array[Enemy]

var _last_time_passed: float = 0.0
var _cur_time_passed: float = 0.0
var _cur_enemy_index: int = 0

var _paused: bool = true

func start():
	_paused = false

func set_enemies(_enemies: Enemies):
	enemies = _enemies.all_purged
	
	for enemy in enemies:
		enemy.setup_first_tick()

func _process(delta):
	if _paused: return
	
	_cur_time_passed += delta
	
	enemies[_cur_enemy_index].process_tick(_last_time_passed)
	
	_cur_enemy_index += 1
	
	if _cur_enemy_index >= enemies.size():
		_cur_enemy_index = 0
		_last_time_passed = _cur_time_passed
		_cur_time_passed = 0.0
