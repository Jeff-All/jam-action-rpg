class_name BattleBuilder

extends Resource

@export var battles_per_tier: Array[int] = [2,4,6,6,6,6,6]

func build():
	pass

func get_cur_battles(cur_tier: int, count: int)-> Array[BattleOptions]:
	return []

func battle_complete(cur_tier: int, battle: BattleOptions):
	pass
