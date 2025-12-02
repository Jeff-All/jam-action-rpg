class_name ActionRest

extends Action

func on_hover_target(attacker: Character, _target: CharacterUI, battle_board: BattleBoard):
	battle_board.mid_text.text = "Recover %s Stamina" % attacker.stamina_recovery

func on_pressed_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard) -> bool:
	super(attacker, target, battle_board)
	print("action_rest.on_pressed_target")
	attacker.modify_resource(Character.CharacterResource.STAMINA, attacker.stamina_recovery)
	
	return true
