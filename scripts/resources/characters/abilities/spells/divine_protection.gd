class_name DivineProtection

extends Ability

@export var base_shield: int = 1
@export var magic_to_shield: float = 1.0
@export var strength_to_shield: float = 1.0
@export var shield_transference: float = 1.0

func execute(ability_button: AbilityButton, source: PCUI, target):
	super(ability_button, source, target)
	var amount = (source._character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted * magic_to_shield) + (source._character.attributes[CharacterCampaign.Attributes.STRENGTH].adjusted * strength_to_shield + base_shield)
	var source_shields = source._character.resources[CharacterCampaign.Resources.SHIELDING].cur
	if target == source:
		if source_shields < amount: source.add_shield(amount)
	else:
		amount += (source_shields)
		if target._character.resources[CharacterCampaign.Resources.SHIELDING].cur < amount:
			target._character.resources[CharacterCampaign.Resources.SHIELDING].cur = amount
			if source_shields > 0:
				source._character.resources[CharacterCampaign.Resources.SHIELDING].cur = 0
