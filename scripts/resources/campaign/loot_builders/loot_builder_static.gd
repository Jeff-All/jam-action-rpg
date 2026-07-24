class_name  LootBuilderStatic

extends LootBuilder

@export var tiers: Array[LootBuilderStaticTier]

func get_loot(tier: int, battle: BattleOptions) -> Array[Resource]:
	var cur = tiers[tier].items.duplicate()
	cur.shuffle()
	return cur.slice(0,3)
	
