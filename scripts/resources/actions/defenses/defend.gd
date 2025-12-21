class_name Defend

extends Action

func defend(hit_on: int, attacker: Enemy, defender: PlayerCharacter) -> bool:
	var attack = attacker.attack * 5
	var defense = defender.defense * 5
	
	var roll = randi_range(1,100)
	
	print("defend %s + %s - %s [%s] >= %s" % [roll, attack, defense, roll + attack - defense , hit_on])
	
	return roll + attack - defense >= hit_on

func reduce(damage: int) -> int:
	return damage

func render_tooltip_full(pc: PlayerCharacter, enemy: Enemy, tooltip: ToolTip):
	tooltip.text = "Defend\n%s%% chance to hit\n%s - %s damage" % [max(0, 70 + ((enemy.attack - pc.defense) * 5)), 2, 4]
