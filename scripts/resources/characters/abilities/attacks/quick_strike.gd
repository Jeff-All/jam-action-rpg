class_name QuickStrike

extends AbilityAttack

func get_cooldown(ability_button: AbilityButton, source: PCUI, target) -> float:
	return source.character.character_campaign.weapon.speed
