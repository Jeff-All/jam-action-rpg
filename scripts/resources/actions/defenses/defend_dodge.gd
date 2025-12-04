class_name DefendDodge

extends Defend

func defend(hit_on: int, attacker: Enemy, defender: PlayerCharacter) -> bool:
	var attack = attacker.attack * 5
	var defense = (defender.defense + defender.agility) * 5
	
	var roll = randi_range(1,100) 
	
	consume_resources(defender)
	
	print("defend %s + %s - %s [%s] >= %s" % [roll, attack, defense, roll + attack - defense , hit_on])
	
	return roll + attack - defense >= hit_on
