class_name CampaignOptions

extends Resource

@export var name: String
@export var character_start_options: Array[CharacterStartOptions]
@export var starting_gold: int
@export var max_inventory: int
@export var starting_inventory: Array[Resource]
@export var battle_builder: BattleBuilder

@export var tiers: Array[CampaignTier]

func _duplicate(deep: bool = false) -> CampaignOptions:
	var new_self = duplicate(deep)
	var new_tiers: Array[CampaignTier] = []
	for cur in tiers:
		new_tiers.append(cur.duplicate())
	new_self.tiers = new_tiers
	return new_self
