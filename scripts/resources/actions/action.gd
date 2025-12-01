class_name Action

extends Resource

@export var name: String
@export var attribute: Character.Attribute
@export var texture: Texture2D
@export var targeting: Targeting

@export var cost: Dictionary[Character.CharacterResource, int]

func on_hover_target(_attacker: Character, _target: CharacterUI, _battle_board: BattleBoard):
	print("action.on_hover_target")

func on_leave_target(_attacker: Character, _target: CharacterUI, battle_board: BattleBoard):
	print("action.on_leave_target")
	battle_board.mid_text.visible = false

func on_pressed_target(_attacker: Character, _target: CharacterUI, _battle_board: BattleBoard) -> bool:
	print("action.on_pressed_target")
	consume_resources(_attacker)
	return false

func can_afford(character: Character) -> bool:
	for cur in cost:
		print("cost %s" % cost[cur])
		if character.get_resource(cur) < cost[cur]:
			return false
	return true

func consume_resources(character: Character):
	for cur in cost:
		character.modify_resource(cur, cost[cur] * -1)
