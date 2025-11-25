class_name Encounter

extends Resource

@export var back_row: Array[BaseEnemy]
@export var front_row: Array[BaseEnemy]

func build_enemies() -> Enemies:
	var enemies = Enemies.new()
	
	for cur_index in back_row.size():
		var cur = back_row[cur_index]
		if cur != null:
			enemies.back_row.append(cur.build_enemy())
		else:
			enemies.back_row.append(null)
	
	for cur_index in front_row.size():
		var cur = front_row[cur_index]
		if cur != null:
			enemies.front_row.append(cur.build_enemy())
		else:
			enemies.front_row.append(null)
	
	return enemies
