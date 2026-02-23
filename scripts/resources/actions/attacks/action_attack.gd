class_name AttackAction

extends Action

func get_cast_time(caster: Character) -> float:
	return caster.weapon.speed

func on_hover_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var hit_chance = min(100, attacker.weapon.hit + ((attacker.attack - target.character.defense) * 5))
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
		on_hit(attacker, target, battle_board)
	else:
		battle_board.combat_text.show_combat_text(target.center, "MISS")
	
	return true

func on_hit(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var damage = randi_range(attacker.weapon.min_damage, attacker.weapon.max_damage) + _attribute_damage
	
	target.character.take_damage_from_player_character(attacker, damage)
	battle_board.combat_text.show_combat_text(target.center, "%s" % damage)

func render_tooltip(attacker: Character, tooltip:ToolTip):
	var hit_chance = min(100, attacker.weapon.hit + (attacker.attack * 5))
	var _attribute_damage = attacker.get_attribute(attacker.weapon.attribute)
	var _min_damage = attacker.weapon.min_damage + _attribute_damage
	var _max_damage = attacker.weapon.max_damage + _attribute_damage
	tooltip.text = "%s%% chance to hit\n%s - %s damaage" % [hit_chance, _min_damage, _max_damage]

func apply(attacker: Character, target: Character):
	target.take_damage(randi_range(attacker.weapon.min_damage, attacker.weapon.max_damage))
