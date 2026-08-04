class_name EnemySkeletalRaider

extends Enemy

@export var ability_cleave_armor: EnemyAbility
var ability_cleave_armor_roll_adjustment: int = 0

func pick_ability(cur: EnemyUI, _battle: BattleUI) -> Array:
	if !find_target_cleave_armor(_battle, cur).has_buff(ability_cleave_armor.buff):
		var roll = randi_range(0,5)
		if roll >= 5 - ability_cleave_armor_roll_adjustment:
			ability_cleave_armor_roll_adjustment = -3
			var target = find_target_cleave_armor(_battle, cur)
			if target != null:
				return [ability_cleave_armor, target]
		else: ability_cleave_armor_roll_adjustment += 1
	return [ability_attack, find_target_attack(cur)]

func execute_ability(ability: EnemyAbility, target, _battle: BattleUI):
	match ability:
		ability_attack:
			execute_attack(target)
		ability_cleave_armor:
			execute_cleave_armor(_battle, target)

func find_target_cleave_armor(_battle: BattleUI, _enemy: EnemyUI) -> PCUI:
	var cur_target = _enemy.enemy.threat_table.find_target()
	var cur_armor = cur_target.character.attributes[CharacterCampaign.Attributes.ARMOR].adjusted
	for cur in _battle.pcs:
		if cur.character != null:
			if !cur.dead:
				if cur_armor == 0 && cur.character.attributes[CharacterCampaign.Attributes.ARMOR].adjusted > 0:
					cur_target = cur
					cur_armor = cur.character.attributes[CharacterCampaign.Attributes.ARMOR].adjusted
	if cur_armor == 0:
		return null
	return cur_target

func execute_cleave_armor(_battle: BattleUI, target):
	target.apply_buff(ability_cleave_armor.buff, self)
