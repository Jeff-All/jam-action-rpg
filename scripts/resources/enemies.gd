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
