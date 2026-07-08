class_name BuffPCIntimidatingHowl

extends BuffPC

@export var stamina_reduction: int = 1

func apply(pc: PCUI):
	pc._character.character_campaign.recovery[CharacterCampaign.Resources.STAMINA] -= stamina_reduction

func remove(pc: PCUI):
	pc._character.character_campaign.recovery[CharacterCampaign.Resources.STAMINA] += stamina_reduction
