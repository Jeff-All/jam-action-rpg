class_name Action

extends Resource

@export var name: String
@export var attribute: Character.Attribute
@export var texture: Texture2D
@export var targeting: Targeting

@export var cost: Dictionary[Character.CharacterResource, int]

@export var instant: bool = false
@export var base_cast_time: float = 0.0
@export var cooldown: float = 0.0

@export var buffs: Dictionary[String, Buff]

func get_icon() -> Texture2D:
	return texture

func _to_string() -> String:
	return name

func get_cast_time(_caster: Character) -> float:
	return base_cast_time

func on_hover_target(_attacker: Character, _target: CharacterUI, _battle_board: BattleBoard):
	print("action.on_hover_target")

func on_leave_target(_attacker: Character, _target: CharacterUI, battle_board: BattleBoard):
	print("action.on_leave_target")
	battle_board.tooltip.visible = false

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

func render_tooltip(_attacker: PlayerCharacter, tooltip:ToolTip):
	tooltip.text = "default action tooltip"

func render_tooltip_full(_pc: PlayerCharacter, _enemy: Enemy, tooltip: ToolTip):
	tooltip.text = "default full action tooltip"

func apply(_buffs:Dictionary[String, BuffState], _attacker: Character, _target: Character):
	pass

func get_cooldown(_character: Character) -> float:
	return cooldown

func get_header() -> String:
	return name

func get_description() -> String:
	return "Default Action"

func get_cost_description() -> String:
	var to_return = ""
	for cur in cost:
		if to_return != "":
			to_return += "\n"
		to_return += "%s: %s" % [Character.get_resource_name(cur), cost[cur]]
	return to_return

func get_cooldown_description() -> String:
	return "Cooldown: %s" % cooldown
