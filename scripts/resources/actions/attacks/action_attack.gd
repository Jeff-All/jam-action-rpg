class_name AttackAction

extends Action

func get_cooldown(character: Character) -> float:
	return maxf(character.weapon.speed, cooldown)

func get_cast_time(caster: Character) -> float:
	return caster.weapon.speed

func on_hover_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var hit_chance = min(100, attacker.weapon.hit + ((attacker.attack - target.character.defense) * 10))
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var _min_damage = attacker.weapon.min_damage + _attribute_damage
	var _max_damage = attacker.weapon.max_damage + _attribute_damage
	print("attack_action.on_hover_target() attacker %s attacking %s has a %s%% chance to hit for %s - %s damage" % [attacker.name, target.character.name, hit_chance, _min_damage, _max_damage])
	battle_board.tooltip.text = "%s%% chance to hit\n%s - %s damage" %[ hit_chance, _min_damage, _max_damage]
	battle_board.tooltip.visible = true

func on_pressed_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard) -> bool:
	super(attacker, target, battle_board)
	
	var roll = randi_range(1,100)
	if roll < attacker.weapon.hit + attacker.attack - target.character.defense:
		pass
	else:
		battle_board.combat_text.show_combat_text(target.center, "MISS")
	
	return true

func on_hit(attacker: Character, target: Character):
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var damage = randi_range(attacker.weapon.min_damage, attacker.weapon.max_damage) + _attribute_damage
	
	target.take_damage(attacker, damage)

func render_tooltip(attacker: Character, tooltip:ToolTip):
	var hit_chance = min(100, attacker.weapon.hit + (attacker.attack * 10))
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var _min_damage = attacker.weapon.min_damage + _attribute_damage
	var _max_damage = attacker.weapon.max_damage + _attribute_damage
	tooltip.text = "%s%% chance to hit\n%s - %s damaage" % [hit_chance, _min_damage, _max_damage]

func apply(_buffs:Dictionary[String, BuffState], attacker: Character, target: Character):
	roll_attack(attacker, target)
	
	consume_resources(attacker)

func roll_attack(attacker: Character, target: Character):
	var roll = randi_range(1,100)
	if roll < attacker.weapon.hit + ((attacker.attack - target.defense) * 10):
		on_hit(attacker, target)
	else:
		target.defended_attack()

func get_header() -> String:
	return name

func get_description() -> String:
	return "Attack"
