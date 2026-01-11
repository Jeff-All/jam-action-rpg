class_name EndTurnAction

extends Action

func on_pressed_target(_attacker: Character, _target: CharacterUI, _battle_board: BattleBoard) -> bool:
	return true

func render_tooltip(_attacker: PlayerCharacter, tooltip:ToolTip):
	tooltip.text = "End Turn"
