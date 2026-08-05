class_name Enemy

extends Resource

@export var name: String
@export var texture: Texture2D

@export var health: int
@export var armor: int
@export var durability: int
@export var stamina: int
@export var mana: int

@export var dodge: int

@export var ability_attack: EnemyAbility

func get_enemy_battle() -> EnemyBattle:
	return EnemyBattle.new(self)

func pick_ability(cur: EnemyUI, _battle: BattleUI) -> Array:
	return [ability_attack, find_target_attack(cur)]

func find_target_attack(cur: EnemyUI):
	return cur.enemy.threat_table.find_target()

func execute_ability(cur: EnemyUI, ability: EnemyAbility, target, _battle: BattleUI):
	match ability:
		ability_attack:
			execute_attack(cur, target)

func execute_attack(cur: EnemyUI, target):
	var roll = Global.roll()
	if roll <= ability_attack.floats["Hit"]:
		roll = Global.roll()
		if roll <= target.character.attributes[CharacterCampaign.Attributes.DODGE].adjusted:
			target.spawn_combat_text("DODGE")
			return
		var damage = randi_range(ability_attack.floats["MinDamage"], ability_attack.floats["MaxDamage"])
		target.take_damage(cur, damage)
	else:
		target.spawn_combat_text("MISS")
