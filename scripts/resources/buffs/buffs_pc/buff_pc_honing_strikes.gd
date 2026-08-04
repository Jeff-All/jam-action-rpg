class_name BuffPCHoningStrikes

extends BuffPC

@export var base_hit_per_stack: int
@export var hit_per_stack_per_agility: int

var to_hit_total: int = 0

var pc: PCUI

func apply(_pc: PCUI):
	pc = _pc
	add_stack()

func remove(_pc: PCUI):
	stacks = 0
	pc.character.attributes[CharacterCampaign.Attributes.ATTACKHIT].remove_adjustment(self)

func add_stack():
	to_hit_total += (base_hit_per_stack + max(0, hit_per_stack_per_agility * pc.character.attributes[CharacterCampaign.Attributes.AGILITY].adjusted))
	stacks = to_hit_total
	print("HoningStrike.add_stack(): %s" % to_hit_total)
	pc.character.attributes[CharacterCampaign.Attributes.ATTACKHIT].add_adjustment(self, to_hit_total)
