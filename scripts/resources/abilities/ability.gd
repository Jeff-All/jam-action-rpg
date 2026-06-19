class_name Ability

extends Resource

@export var name: String
@export var texture: Texture2D
@export var targeting: Targeting
@export var cost: Dictionary[String, int]
@export var instant: bool = false
@export var base_cast_time: float = 0.0
@export var cooldown: float = 0.0

func get_icon() -> Texture2D:
	return texture

func _to_string() -> String:
	return name

func get_header() -> String:
	return name

func get_description() -> String:
	return "Default Action"

func get_cost_description() -> String:
	var to_return = ""
	for cur in cost:
		if to_return != "":
			to_return += "\n"
		to_return += "%s: %s" % [cur, cost[cur]]
	return to_return

func get_cooldown_description() -> String:
	return "Cooldown: %s" % cooldown
