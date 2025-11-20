class_name RangedTargeting

extends Targeting

func target(character: Character, battle_board: BattleBoard):
	super.target(character, battle_board)
	for cur_enemy_ui in battle_board.enemies:
		cur_enemy_ui.available = true
