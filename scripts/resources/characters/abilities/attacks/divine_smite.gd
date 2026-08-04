class_name DivineSmite

extends AbilityAttack

@export var base_shield: int = 1
@export var damage_to_shield: float = 0.1
@export var shield_to_damage: float = 0.1

func inflict(_ability_button: AbilityButton, source: PCUI, target):
	var damage = randi_range(source.character.character_campaign.weapon.min_damage, source.character.character_campaign.weapon.max_damage)
	var shield = source.character.resources[CharacterCampaign.Resources.SHIELDING].cur
	if shield <= 0:
		source.add_shield((damage * damage_to_shield + source.character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted) + base_shield)
	else:
		damage += (shield * shield_to_damage) + source.character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted
		source.character.resources[CharacterCampaign.Resources.SHIELDING].cur = 0
	target.enemy.cur_health -= damage
	target.enemy.add_threat(source, max(0, damage - source.character.attributes[CharacterCampaign.Attributes.SUBTLETY].adjusted))
	target.spawn_combat_text("%s" % damage)
