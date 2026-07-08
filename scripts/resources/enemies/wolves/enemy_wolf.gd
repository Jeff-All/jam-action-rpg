class_name EnemyWolf

extends Enemy

@export var ability_inimidating_howl: EnemyAbility

var intimidating_howl_roll_adjustment: int = 0

func pick_ability(cur: EnemyUI, _battle: BattleUI) -> Array:
	if !find_target_intimidating_howl(cur).buffs.has(ability_inimidating_howl.buff):
		var roll = randi_range(0,5)
		if roll >= 5 - intimidating_howl_roll_adjustment:
			return [ability_inimidating_howl, find_target_intimidating_howl(cur)]
		intimidating_howl_roll_adjustment += 1
	return [ability_attack, find_target_attack(cur)]

func execute_ability(ability: EnemyAbility, target, _battle: BattleUI):
	match ability:
		ability_attack:
			execute_attack(target)
		ability_inimidating_howl:
			execute_intimidating_howl(_battle)

func find_target_intimidating_howl(cur: EnemyUI):
	return cur.enemy.threat_table.find_target()

func execute_intimidating_howl(_battle: BattleUI):
	for cur in _battle.pcs:
		if cur.character != null:
			if !cur.dead:
				cur.apply_buff(ability_inimidating_howl.buff)
