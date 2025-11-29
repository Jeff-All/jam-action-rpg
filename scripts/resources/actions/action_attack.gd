class_name AttackAction

extends Action

@export var min_damage: int
@export var max_damage: int

func on_hover_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard):
	var hit_chance = min(100, 80 + ((attacker.attack - target.character.defense) * 5))
	var _attribute_damage = attacker.get_attribute(attribute)
	var _min_damage = min_damage + _attribute_damage
	var _max_damage = max_damage + _attribute_damage
	print("attack_action.on_hover_target() attacker %s attacking %s has a %s%% chance to hit for %s - %s damage" % [attacker.name, target.character.name, hit_chance, _min_damage, _max_damage])
	battle_board.mid_text.text = "%s%% chance to hit\n%s - %s damage" %[ hit_chance, _min_damage, _max_damage]

func on_pressed_target(attacker: Character, target: CharacterUI, _battle_board: BattleBoard) -> bool:
	var _attribute_damage = attacker.get_attribute(attribute)
	var damage = randi_range(min_damage, max_damage) + _attribute_damage
	target.character.take_damage_from_player_character(attacker, damage)
	return true
