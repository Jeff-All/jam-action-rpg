class_name TraitRetributiveDivinity

extends Trait

@export var base_damage: float = 1.0
@export var damage_per_magic: float = 1.0

var pcui: PCUI

func apply(_pcui: PCUI, _battle: Battle):
	pcui = _pcui
	pcui.on_shield_damaged.connect(_on_character_shield_damage)

func remove(_pcui: PCUI):
	pcui.on_shield_damaged.disconnect(_on_character_shield_damage)
	pcui = null

func _on_character_shield_damage(pc: PCUI, attacker: EnemyUI, _value: float):
	var damage = (damage_per_magic * pcui.character.attributes[CharacterCampaign.Attributes.MAGIC].adjusted) + base_damage
	attacker.enemy.cur_health -= damage
	attacker.enemy.add_threat(pcui, max(0, damage - pcui.character.attributes[CharacterCampaign.Attributes.SUBTLETY].adjusted))
	attacker.spawn_combat_text("%s" % damage)
