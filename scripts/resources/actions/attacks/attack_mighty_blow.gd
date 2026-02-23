class_name AttackMightyBlow

extends AttackAction

func on_hit(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var _attribute_damage = attacker.get_attribute(attribute)
	var damage = randi_range(min_damage, max_damage) + _attribute_damage + attacker.get_attribute(Character.Attribute.STRENGTH)
	
	target.character.take_damage_from_player_character(attacker, damage)
	battle_board.combat_text.show_combat_text(target.center, "%s" % damage)
