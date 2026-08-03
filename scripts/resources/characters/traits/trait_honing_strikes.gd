class_name TraitHoningStrikes

extends Trait

@export var buff: BuffPCHoningStrikes

var pcui: PCUI

func apply(_pcui: PCUI):
	print("honing_strike.apply")
	pcui = _pcui
	pcui.on_attack_hit.connect(_on_character_attack_hit)
	pcui.on_attack_missed.connect(_on_character_attack_miss)

func remove(_pcui: PCUI):
	print("honing_strike.remove")
	pcui.on_attack_hit.disconnect(_on_character_attack_hit)
	pcui.on_attack_missed.disconnect(_on_character_attack_miss)
	pcui = null

func _on_character_attack_hit(_pc: PCUI):
	print("honing_strike._on_character_attack_hit")
	pcui.remove_buff(buff)

func _on_character_attack_miss(_pc: PCUI):
	print("honing_strike._on_character_attack_miss")
	pcui.apply_buff(buff, null)
