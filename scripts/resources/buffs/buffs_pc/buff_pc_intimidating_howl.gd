class_name BuffPCIntimidatingHowl

extends BuffPC

@export var stamina_reduction: int = -1

func apply(pc: PCUI):
	pc.character.resources[CharacterCampaign.Resources.STAMINA]._recovery.add_adjustment(uname, stamina_reduction)

func remove(pc: PCUI):
	pc.character.resources[CharacterCampaign.Resources.STAMINA]._recovery.remove_adjustment(uname)
