class_name TargetingSelf

extends TargetingA

func target(character: Character, battle_board: BattleBoard):
	super.target(character, battle_board)
	for cur_pc_ui in battle_board.pcs.character_uis:
		if cur_pc_ui.character == character:
			cur_pc_ui.available = true
