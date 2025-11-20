class_name Action

extends Resource

@export var name: String
@export var attribute: Character.Attribute
@export var texture: Texture2D
@export var targeting: Targeting

func on_hover_target(_attacker: Character, _target: CharacterUI, _battle_board: BattleBoard):
	print("action.on_hover_target")

func on_leave_target(_attacker: Character, _target: CharacterUI, battle_board: BattleBoard):
	print("action.on_leave_target")
	battle_board.mid_text.visible = false

func on_pressed_target(_attacker: Character, _target: CharacterUI, _battle_board: BattleBoard) -> bool:
	print("action.on_pressed_target")
	return false
