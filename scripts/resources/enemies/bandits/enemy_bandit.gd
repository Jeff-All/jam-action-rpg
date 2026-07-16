class_name EnemyBandit

extends Enemy

@export var ability_mageblood_poison: EnemyAbility
var ability_cleave_armor_roll_adjustment: int = 0

func pick_ability(cur: EnemyUI, _battle: BattleUI) -> Array:
	var mageblood_poison_target = find_target_mageblood_poison(_battle.pcs)
	if !mageblood_poison_target.has_buff(ability_mageblood_poison.buff):
		var roll = randi_range(0,5)
		if roll >= 5 - ability_cleave_armor_roll_adjustment:
			ability_cleave_armor_roll_adjustment = -3
			return [ability_mageblood_poison, mageblood_poison_target]
		ability_cleave_armor_roll_adjustment += 1
	return [ability_attack, find_target_attack(cur)]

func execute_ability(ability: EnemyAbility, target, battle: BattleUI):
	match ability:
		ability_attack:
			execute_attack(target)
		ability_mageblood_poison:
			execute_mageblood_poison(target, battle)

func find_target_mageblood_poison(pcs: Array[PCUI]) -> PCUI:
	var target: PCUI = null
	for cur in pcs:
		if cur._character != null && !cur._dead:
			if target == null:
				target = cur
			else: if target._character.resources[CharacterCampaign.Resources.MANA]._recovery.adjusted < cur._character.resources[CharacterCampaign.Resources.MANA]._recovery.adjusted:
				target = cur
	return target

func execute_mageblood_poison(target, battle: BattleUI):
	target.apply_buff(ability_mageblood_poison.buff, self)
