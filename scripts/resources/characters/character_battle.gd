class_name CharacterBattle

extends Resource

signal on_resources_consumed(cost: Dictionary[CharacterCampaign.Resources, int])
signal on_cur_resource_change(resource: AdjustableResource, change: float)
signal on_attribute_change(attribute: CharacterCampaign.Attributes, value: int)
signal on_death(character: CharacterBattle)

var character_campaign: CharacterCampaign

var attributes: Dictionary[CharacterCampaign.Attributes, AdjustableAttribute] = {
	CharacterCampaign.Attributes.STRENGTH: AdjustableAttribute.new(CharacterCampaign.Attributes.STRENGTH),
	CharacterCampaign.Attributes.AGILITY: AdjustableAttribute.new(CharacterCampaign.Attributes.AGILITY),
	CharacterCampaign.Attributes.MAGIC: AdjustableAttribute.new(CharacterCampaign.Attributes.MAGIC),
	CharacterCampaign.Attributes.ARMOR: AdjustableAttribute.new(CharacterCampaign.Attributes.ARMOR),
	CharacterCampaign.Attributes.SPELLHIT: AdjustableAttribute.new(CharacterCampaign.Attributes.SPELLHIT),
	CharacterCampaign.Attributes.DODGE: AdjustableAttribute.new(CharacterCampaign.Attributes.DODGE),
}

var resources: Dictionary[CharacterCampaign.Resources, AdjustableResource] = {
	CharacterCampaign.Resources.HEALTH: AdjustableResource.new(CharacterCampaign.Resources.HEALTH, 10.0),
	CharacterCampaign.Resources.ARMOR: AdjustableResource.new(CharacterCampaign.Resources.ARMOR, 0),
	CharacterCampaign.Resources.DURABILITY: AdjustableResource.new(CharacterCampaign.Resources.DURABILITY, 0),
	CharacterCampaign.Resources.SHIELDING: AdjustableResource.new(CharacterCampaign.Resources.SHIELDING, 0),
	CharacterCampaign.Resources.STAMINA: AdjustableResource.new(CharacterCampaign.Resources.STAMINA, 5),
	CharacterCampaign.Resources.MANA: AdjustableResource.new(CharacterCampaign.Resources.MANA, 5),
}

var traits: Array[Trait]

func _on_cur_resource_change(resource: AdjustableResource, _change: float):
	match resource.resource:
		CharacterCampaign.Resources.HEALTH:
			if resource.cur <= 0:
				on_death.emit(self)
	on_cur_resource_change.emit(resource, _change)

func _on_attribute_change(attribute: AdjustableAttribute):
	on_attribute_change.emit(attribute.attribute, attribute.adjusted)

func add_cur_resource(resource: CharacterCampaign.Resources, value: float):
	set_cur_resource(resource, resources[resource].cur + value)

func set_cur_resource(resource: CharacterCampaign.Resources, value: float):
	resources[resource].cur = value

func _init(_character_campaign: CharacterCampaign):
	character_campaign = _character_campaign
	
	for cur in character_campaign.attributes:
		attributes[cur].base =  character_campaign.attributes[cur]
		attributes[cur].on_change.connect(_on_attribute_change)
	
	for cur in character_campaign.resources:
		resources[cur]._max.base = character_campaign.resources[cur]
		resources[cur].cur = character_campaign.resources[cur]
		resources[cur]._recovery.base = character_campaign.recovery[cur]
		resources[cur].on_cur_changed.connect(_on_cur_resource_change)
	
	for cur in character_campaign.traits:
		if cur != null:
			traits.append(cur.duplicate())

func can_afford(ability: Ability) -> bool:
	for cur in ability.cost:
		if ability.cost[cur] > resources[cur].cur:
			return false
	return true

func consume_resources(cost: Dictionary[CharacterCampaign.Resources, int]):
	for cur in cost:
		resources[cur].cur -= cost[cur]
	on_resources_consumed.emit(cost)
