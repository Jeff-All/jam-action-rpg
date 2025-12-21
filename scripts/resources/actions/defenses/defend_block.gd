class_name DefendBlock

extends Defend

func defend(_hit_on: int, _attacker: Enemy, _defender: PlayerCharacter) -> bool:
	return true

func reduce(damage: int) -> int:
	return max(0,damage - 1)

func render_tooltip_full(_pc: PlayerCharacter, _enemy: Enemy, tooltip: ToolTip):
	tooltip.text = "Block\n100% chance to hit\n1 - 3 Damage\n reduces damage of the attack by 1"
