class_name EnemySkeletalRaider

extends Enemy

@export var ability_cleave_armor: EnemyAbility
var ability_cleave_armor_roll_adjustment: int = 0

func pick_ability(cur: EnemyUI, _battle: BattleUI) -> Array:
	if !find_target_cleave_armor(cur).has_buff(ability_cleave_armor.buff):
		var roll = randi_range(0,5)
		if roll >= 5 - ability_cleave_armor_roll_adjustment:
			ability_cleave_armor_roll_adjustment = -3
			return [ability_cleave_armor, find_target_cleave_armor(cur)]
		ability_cleave_armor_roll_adjustment += 1
	return [ability_attack, find_target_attack(cur)]

func execute_ability(ability: EnemyAbility, target, _battle: BattleUI):
	match ability:
		ability_attack:
			execute_attack(target)
		ability_cleave_armor:
			execute_cleave_armor(_battle)

func find_target_cleave_armor(cur: EnemyUI) -> PCUI:
	return cur.enemy.threat_table.find_target()

func execute_cleave_armor(_battle: BattleUI):
	for cur in _battle.pcs:
		if cur.character != null:
			if !cur.dead:
				cur.apply_buff(ability_cleave_armor.buff)
