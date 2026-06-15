class_name AttackPrecisionBlow

extends AttackAction

func on_hit(attacker: Character, target: Character):
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var damage = randi_range(attacker.weapon.min_damage, attacker.weapon.max_damage)
	
	target.take_damage(attacker, damage)

func render_tooltip(attacker: Character, tooltip:ToolTip):
	var hit_chance = min(100, attacker.weapon.hit + ((attacker.attack + attacker.get_attribute(Character.Attribute.AGILITY)) * 10))
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var _min_damage = attacker.weapon.min_damage + _attribute_damage
	var _max_damage = attacker.weapon.max_damage + _attribute_damage
	tooltip.text = "%s Stamina\n%s%% chance to hit\n%s - %s damaage" % [cost[Character.CharacterResource.STAMINA], hit_chance, _min_damage, _max_damage]

func on_hover_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var hit_chance = min(100, attacker.weapon.hit + ((attacker.attack - target.character.defense + attacker.get_attribute(Character.Attribute.AGILITY)) * 10))
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var _min_damage = attacker.weapon.min_damage + _attribute_damage
	var _max_damage = attacker.weapon.max_damage + _attribute_damage
	print("attack_action.on_hover_target() attacker %s attacking %s has a %s%% chance to hit for %s - %s damage" % [attacker.name, target.character.name, hit_chance, _min_damage, _max_damage])
	battle_board.tooltip.text = "%s Stamina\n%s%% chance to hit\n%s - %s damaage" % [cost[Character.CharacterResource.STAMINA], hit_chance, _min_damage, _max_damage]
	battle_board.tooltip.visible = true

func roll_attack(attacker: Character, target: Character):
	var roll = randi_range(1,100)
	if roll < attacker.weapon.hit + ((attacker.attack - target.defense + attacker.get_attribute(Character.Attribute.AGILITY)) * 10):
		on_hit(attacker, target)
	else:
		target.defended_attack()
