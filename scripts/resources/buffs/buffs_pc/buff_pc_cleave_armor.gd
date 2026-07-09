class_name BuffPCCleaveArmor

extends BuffPC

@export var armor_reduction: int = 1

func apply(pc: PCUI):
	pc._character.set_cur_resource(CharacterCampaign.Resources.ARMOR, pc._character.cur_resources[CharacterCampaign.Resources.ARMOR] - armor_reduction)

func remove(pc: PCUI):
	pc._character.set_cur_resource(CharacterCampaign.Resources.ARMOR, pc._character.cur_resources[CharacterCampaign.Resources.ARMOR] + armor_reduction)
