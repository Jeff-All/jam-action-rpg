class_name Targeting

extends Resource

func target(character: Character, battle_board: BattleBoard):
	_reset_targeting(character, battle_board)

func _reset_targeting(_character: Character, battle_board: BattleBoard):
	for cur_pc_ui in battle_board.pcs.character_uis:
		cur_pc_ui.available = false
	
	for cur_enemy_ui in battle_board.enemies:
		cur_enemy_ui.available = false
