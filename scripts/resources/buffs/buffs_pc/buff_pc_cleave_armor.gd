class_name BuffPCCleaveArmor

extends BuffPC

@export var armor_reduction: int = 1

func apply(pc: PCUI):
	pc._character.attributes[CharacterCampaign.Attributes.ARMOR].add_adjustment(uname, armor_reduction)

func remove(pc: PCUI):
	pc._character.attributes[CharacterCampaign.Attributes.ARMOR].remove_adjustment(uname)
