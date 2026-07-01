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

func set_cur_resource(resource: CharacterCampaign.Resources, value: int):
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
