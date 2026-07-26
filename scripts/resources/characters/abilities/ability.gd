class_name Ability

extends Resource

@export var name: String
@export var texture: Texture2D
@export var cost: Dictionary[CharacterCampaign.Resources, int]
@export var instant: bool = false
@export var base_cast_time: float = 0.0
@export var cooldown: float = 0.0
@export var targeting: Targeting = Targeting.SELF
@export var to_hit: int
@export var description: String
@export var on_base_cooldown: bool = true

enum Targeting { SELF, ALLIES, PARTY, MELEE, RANGED, ALL}

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

func execute(ability_button: AbilityButton, source: PCUI, target):
	consume_resources(source)
	ability_button.start_cooldown(get_cooldown(ability_button, source, target))
	if on_base_cooldown:
		source.trigger_base_cooldown()

func consume_resources(source: PCUI):
	source._character.consume_resources(cost)

func get_cost(_resource: CharacterCampaign.Resources) -> int:
	return 0

func get_cooldown(_ability_button: AbilityButton, _source: PCUI, _target) -> float:
	return cooldown
