class_name AbilityAttack

extends Ability

@export var on_attack_cooldown: bool = true

func get_cooldown(ability_button: AbilityButton, source: PCUI, target) -> float:
	return source.character.character_campaign.weapon.speed + cooldown

func execute(ability_button: AbilityButton, source: PCUI, target):
	super(ability_button, source, target)
	if on_attack_cooldown:
		source.trigger_attack_cooldown()
	
	var roll = randi_range(1, 100)
	if did_roll_hit(roll, ability_button, source, target):
		roll = randi_range(1, 100)
		if did_target_dodge(roll, ability_button, source, target):
			target.spawn_combat_text("DODGE")
		inflict(ability_button, source, target)
	else:
		target.spawn_combat_text("MISS")

func did_roll_hit(roll: int, ability_button: AbilityButton, source: PCUI, target) -> bool:
	return roll <= source.character.character_campaign.weapon.hit

func did_target_dodge(roll: int, ability_button: AbilityButton, source: PCUI, target):
	return false # place holder

func inflict(ability_button: AbilityButton, source: PCUI, target):
	var damage = randi_range(source.character.character_campaign.weapon.min_damage, source.character.character_campaign.weapon.max_damage)
	target.enemy.cur_health -= damage
	target.enemy.add_threat(source, damage)
	target.spawn_combat_text("%s" % damage)
