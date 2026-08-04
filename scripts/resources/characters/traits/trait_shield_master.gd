class_name TraitShieldMaster

extends Trait

@export var block_chance_per_agi: float = 1.0
@export var block_value_per_strength: float = 1.0

var pcui: PCUI

func apply(_pcui: PCUI, _battle: Battle):
	pcui = _pcui
	
	pcui.character.attributes[CharacterCampaign.Attributes.BLOCK_CHANCE].add_adjustment(self, _block_chance)
	pcui.character.attributes[CharacterCampaign.Attributes.BLOCK_VALUE].add_adjustment(self, _block_value)

func remove(_pcui: PCUI):
	pcui.character.attributes[CharacterCampaign.Attributes.BLOCK_CHANCE].remove_adjustment(self)
	pcui.character.attributes[CharacterCampaign.Attributes.BLOCK_VALUE].remove_adjustment(self)
	
	pcui = null

func _block_chance() -> float:
	return pcui.character.attributes[CharacterCampaign.Attributes.AGILITY].adjusted * block_chance_per_agi

func _block_value() -> float:
	@warning_ignore("narrowing_conversion")
	return randi_range(0.0, pcui.character.attributes[CharacterCampaign.Attributes.STRENGTH].adjusted * block_value_per_strength)
