class_name BuffPCDesperateFury

extends BuffPC

@export var speed_scale: float = 1.0

func apply(pc: PCUI):
	for cur in pc.abilities:
		if cur.ability is AbilityAttack:
			cur.speed_scale.add_adjustment(self, speed_scale)

func remove(pc: PCUI):
	for cur in pc.abilities:
		if cur.ability is AbilityAttack:
			cur.speed_scale.remove_adjustment(self)
