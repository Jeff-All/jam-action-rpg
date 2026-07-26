class_name EquippableItem

extends Item

@export var attributes: Dictionary[CharacterCampaign.Attributes, float]
@export var resources: Dictionary[CharacterCampaign.Resources, float]
@export var recovery: Dictionary[CharacterCampaign.Resources, float]

func equip(character: CharacterCampaign):
	print("Equip: %s" % name)
	for cur in attributes:
		character.attributes[cur] += attributes[cur]
		print("Add attribute[%s] + %s -> %s" % [CharacterCampaign.Attributes.find_key(cur), attributes[cur], character.attributes[cur]])
	
	for cur in resources:
		character.resources[cur] = character.resources[cur] + resources[cur]
		print("Add resource[%s] + %s -> %s" % [CharacterCampaign.Resources.find_key(cur), resources[cur], character.resources[cur]])
	
	for cur in recovery:
		character.recovery[cur] = character.recovery[cur] + recovery[cur]
		print("Add recovery[%s] + %s -> %s" % [CharacterCampaign.Resources.find_key(cur), recovery[cur], character.recovery[cur]])
	

func unequip(character: CharacterCampaign):
	print("Unequip: %s" % name)
	for cur in attributes:
		character.attributes[cur] -= attributes[cur]
		print("Remove attribute[%s] - %s -> %s" % [CharacterCampaign.Attributes.find_key(cur), attributes[cur], character.attributes[cur]])
	
	for cur in resources:
		character.resources[cur] = character.resources[cur] - resources[cur]
		print("Remove resource[%s] - %s -> %s" % [CharacterCampaign.Resources.find_key(cur), resources[cur], character.resources[cur]])
	
	for cur in recovery:
		character.recovery[cur] = character.recovery[cur] - recovery[cur]
		print("Remove recovery[%s] - %s -> %s" % [CharacterCampaign.Resources.find_key(cur), recovery[cur], character.recovery[cur]])
