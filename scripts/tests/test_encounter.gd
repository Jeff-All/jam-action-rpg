extends MarginContainer

@export var encounter_a: Encounter
@export var encounter_b: Encounter

func _on_set_encounter_a_pressed():
	$CenterContainer/Encounter.set_encounter(encounter_a)

func _on_set_encounter_b_pressed():
	$CenterContainer/Encounter.set_encounter(encounter_b)

func _on_encounter_on_enemy_pressed(enemy, row: int, col: int):
	print("enemy %s pressed at row %s and col %s" % [enemy.name, row, col])
	enemy.cur_health += 1
