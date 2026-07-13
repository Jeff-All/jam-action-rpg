class_name SpellAttack

extends Ability

@export var min_damage: int
@export var max_damage: int

func execute(ability_button: AbilityButton, source: PCUI, target):
	super(ability_button, source, target)
	
	var roll = Global.roll()
	if did_roll_hit(roll, ability_button, source, target):
		roll = Global.roll()
		if did_target_resist(roll, ability_button, source, target):
			target.spawn_combat_text("RESIST")
		inflict(ability_button, source, target)
	else:
		target.spawn_combat_text("MISS")

func did_roll_hit(roll: int, ability_button: AbilityButton, source: PCUI, target) -> bool:
	return roll <= to_hit + source._character.attributes[CharacterCampaign.Attributes.SPELLHIT].adjusted

func did_target_resist(roll: int, ability_button: AbilityButton, source: PCUI, target):
	return false # place holder

func inflict(ability_button: AbilityButton, source: PCUI, target):
	var damage = randi_range(min_damage, max_damage) + source.character.character_campaign.attributes[CharacterCampaign.Attributes.MAGIC]
	target.enemy.take_damage(damage, true)
	target.enemy.add_threat(source, damage)
	target.spawn_combat_text("%s" % damage)
