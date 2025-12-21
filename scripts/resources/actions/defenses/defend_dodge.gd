class_name DefendDodge

extends Defend

func defend(hit_on: int, attacker: Enemy, defender: PlayerCharacter) -> bool:
	var attack = attacker.attack * 5
	var defense = (defender.defense + defender.agility) * 5
	
	var roll = randi_range(1,100) 
	
	consume_resources(defender)
	
	print("defend %s + %s - %s [%s] >= %s" % [roll, attack, defense, roll + attack - defense , hit_on])
	
	return roll + attack - defense >= hit_on

func render_tooltip_full(pc: PlayerCharacter, enemy: Enemy, tooltip: ToolTip):
	tooltip.text = "Dodge - 3 Stamina\n%s%% chance to hit\n%s - %s damage\nIncreases Defense by Agility(%s)" % [max(0, 70 + ((enemy.attack - pc.defense - pc.agility) * 5)), 2, 4, pc.agility]
