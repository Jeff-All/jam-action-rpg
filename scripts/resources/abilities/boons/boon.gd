class_name Boon

extends Ability

@export var buff: BuffPC

func execute(ability_button: AbilityButton, source: PCUI, target):
	super(ability_button, source, target)
	
	target.apply_buff(buff)
