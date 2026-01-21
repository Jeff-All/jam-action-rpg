class_name ChronoController

extends Node

var enemies: Array[Enemy]
var pcs: Array[PlayerCharacter]

var _last_time_passed: float = 0.0
var _cur_time_passed: float = 0.0
var _cur_enemy_index: int = 0
var _cur_pc_index: int = 0

var _paused: bool = true

func start():
	_paused = false

func stop():
	_paused = true

func set_enemies(_enemies: Enemies):
	enemies = _enemies.all_purged
	
	for enemy in enemies:
		enemy.setup_first_tick()

func set_pcs(_pcs: PlayerCharacters):
	pcs = _pcs.characters

func _process(delta):
	if _paused: return
	
	_cur_time_passed += delta
	
	if _cur_pc_index < pcs.size():
		pcs[_cur_pc_index].process_tick(_last_time_passed)
	
	if _cur_enemy_index < enemies.size():
		enemies[_cur_enemy_index].process_tick(_last_time_passed)
	
	_cur_enemy_index += 1
	_cur_pc_index += 1
	
	while _cur_enemy_index < enemies.size() && enemies[_cur_enemy_index].dead:
		_cur_enemy_index += 1
	while _cur_pc_index < pcs.size() && pcs[_cur_pc_index].dead:
		_cur_pc_index += 1
	
	if _cur_enemy_index >= enemies.size() && _cur_pc_index >= pcs.size():
		_cur_pc_index = 0
		_cur_enemy_index = 0
		_last_time_passed = _cur_time_passed
		_cur_time_passed = 0.0
