class_name CostBar

extends HBoxContainer

var map: Dictionary[Character.CharacterResource, Cost]

func _ready():
	map[Character.CharacterResource.DURABILITY] = $CostDurability
	map[Character.CharacterResource.HEALTH] = $CostHealth
	map[Character.CharacterResource.STAMINA] = $CostStamina
	map[Character.CharacterResource.MANA] = $CostMana

func reset():
	for cur in map:
		map[cur].visible = false

func set_cost(character: Character, cost: Dictionary[Character.CharacterResource, int]):
	reset()
	for cur in cost:
		var cur_cost = map[cur]
		cur_cost.cost = cost[cur]
		cur_cost.can_afford = character.get_resource(cur) >= cost[cur]
		cur_cost.visible = true
