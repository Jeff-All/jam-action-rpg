class_name RestoreAction

extends Action

@export var base_heal_per_tick: int = 1
@export var base_duration: int = 1

func get_cooldown(_character: Character) -> float:
	return cooldown

func get_cast_time(_caster: Character) -> float:
	return 0.0

func on_pressed_target(attacker: Character, target: CharacterUI, battle_board: BattleBoard) -> bool:
	super(attacker, target, battle_board)
	
	return true

func render_tooltip(caster: Character, tooltip:ToolTip):
	tooltip.text = "restores %s health every second for %s seconds" % [base_heal_per_tick, (caster.magic + base_duration)]

func apply(_buffs:Dictionary[String, BuffState], caster: Character, target: Character):
	consume_resources(caster)
	var active = _buffs["Restore"].new_active(caster, target)
	active.variables["heal_per_tick"] = base_heal_per_tick
	active.variables["initial_duration"] = caster.magic + base_duration
	active.variables["remaining_duration"] = caster.magic + base_duration
	target.apply_buff(active)
