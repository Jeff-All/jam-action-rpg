class_name EnemyUI

extends VBoxContainer

@export var flip: bool = false

var enemy_pane: EnemyPane
var status_bars: StatusBars

var _enemy: EnemyBattle

var enemy: EnemyBattle:
	set(value):
		_enemy = value
		enemy_pane.enemy = value.base
		bind_status_bars()
	get:
		return _enemy

func _ready():
	enemy_pane = $EnemyPane
	status_bars = $EnemyPane/VBoxContainer/StatusBars
	
	enemy_pane.flip = flip

func _on_mouse_entered():
	enemy_pane.texture_rect.material.set_shader_parameter("index", 1)

func _on_mouse_exited():
	enemy_pane.texture_rect.material.set_shader_parameter("index", 0)

func bind_status_bars():
	print("EnemyUI.bind_status_bars()")
	status_bars.max_health = _enemy.base.health
	status_bars.cur_health = _enemy.cur_health
	status_bars.cur_armor = _enemy.cur_armor
	status_bars.max_durability = _enemy.base.durability
	status_bars.cur_durability = _enemy.cur_durability
	status_bars.max_stamina = _enemy.base.stamina
	status_bars.cur_stamina = _enemy.cur_stamina
	status_bars.max_mana = _enemy.base.mana
	status_bars.cur_mana = _enemy.cur_mana
