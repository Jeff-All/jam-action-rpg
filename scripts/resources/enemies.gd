class_name Enemies

extends Resource

signal on_enemies_dead()

@export var front_row: Array[Enemy]
@export var back_row: Array[Enemy]

func bind_enemies():
	for cur_enemy in all:
		if cur_enemy != null:
			bind_enemy(cur_enemy)

func bind_enemy(enemy: Enemy) :
	enemy.on_death.connect(_on_enemy_death)

func build_threat_tables(pcs: PlayerCharacters):
	for cur_enemy in front_row + back_row:
		if cur_enemy != null:
			cur_enemy.threat_table.set_table(pcs)

func _on_enemy_death(_enemy: Enemy):
	print("_on_enemy_death: %s" % _enemy.name)
	for cur_enemy in all:
		if cur_enemy != null:
			if !cur_enemy.dead: 
				return
	on_enemies_dead.emit()

var all: Array[Enemy]:
	get():
		return front_row + back_row

var all_purged: Array[Enemy]:
	get():
		var _all = all
		var to_return:Array[Enemy] = []
		for cur in _all:
			if cur != null:
				to_return.append(cur)
		return to_return

func prepare_for_battle():
	for cur_enemy in front_row + back_row:
		if cur_enemy != null:
			cur_enemy.prepare_for_battle()
