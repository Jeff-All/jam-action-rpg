class_name MightyBlow

extends AbilityAttack

func inflict(ability_button: AbilityButton, source: PCUI, target):
	var damage = randi_range(source.character.character_campaign.weapon.min_damage, source.character.character_campaign.weapon.max_damage) + source.character.character_campaign.attributes[CharacterCampaign.Attributes.STRENGTH] as int
	target.enemy.cur_health -= damage
	target.spawn_combat_text("%s" % damage)
