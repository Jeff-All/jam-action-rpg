class_name Defend

extends Action

func defend(hit_on: int, attacker: Enemy, defender: PlayerCharacter) -> bool:
	var attack = attacker.attack * 5
	var defense = defender.defense * 5
	
	var roll = randi_range(1,100)
	
	print("defend %s + %s - %s [%s] >= %s" % [roll, attack, defense, roll + attack - defense , hit_on])
	
	return roll + attack - defense >= hit_on
