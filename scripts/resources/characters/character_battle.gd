class_name CharacterBattle

extends Resource

signal on_cur_resource_change(resource: CharacterCampaign.Resources, value: int)

var character_campaign: CharacterCampaign

var cur_resources: Dictionary[CharacterCampaign.Resources, int] = {
	CharacterCampaign.Resources.HEALTH: 10,
	CharacterCampaign.Resources.ARMOR: 0,
	CharacterCampaign.Resources.DURABILITY: 0,
	CharacterCampaign.Resources.SHIELDING: 0,
	CharacterCampaign.Resources.STAMINA: 5,
	CharacterCampaign.Resources.MANA: 5,
}

var cur_resources_floats: Dictionary[CharacterCampaign.Resources, float] = {
	CharacterCampaign.Resources.HEALTH: 0.0,
	CharacterCampaign.Resources.ARMOR: 0.0,
	CharacterCampaign.Resources.DURABILITY: 0.0,
	CharacterCampaign.Resources.SHIELDING: 0.0,
	CharacterCampaign.Resources.STAMINA: 0.0,
	CharacterCampaign.Resources.MANA: 0.0,
}

func add_cur_resource(resource: CharacterCampaign.Resources, value: float):
	var cur_float = cur_resources_floats[resource] + value
	if cur_float >= 1.0:
		var new_value = cur_resources[resource] + int(floor(cur_float))
		cur_resources_floats[resource] = cur_float - floor(cur_float)
		set_cur_resource(resource, new_value)
	else:
		cur_resources_floats[resource] = cur_float

func set_cur_resource(resource: CharacterCampaign.Resources, value: int):
	if value >= character_campaign.resources[resource]:
		cur_resources_floats[resource] = 0.0
		value = character_campaign.resources[resource]
	if cur_resources[resource] != value:
		cur_resources[resource] = value
		on_cur_resource_change.emit(resource, value)

func _init(_character_campaign: CharacterCampaign):
	character_campaign = _character_campaign
	
	for cur in character_campaign.resources:
		cur_resources[cur] = character_campaign.resources[cur]

func can_afford(ability: Ability) -> bool:
	for cur in ability.cost:
		if ability.cost[cur] > cur_resources[cur]:
			return false
	return true
