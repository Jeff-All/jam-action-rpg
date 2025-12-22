class_name EnemyTurnInputState

extends InputState

var enemy: Enemy
var target: PlayerCharacter

var next: Callable = _target

var timer: Timer:
	set(value):
		_timer = value
		_timer.timeout.connect(_on_timer)

var _timer: Timer

func begin():
	print("enemy_turn.begin")
	battle_board.reset()
	
	enemy.active = true
	next = _target
	
	_timer.start()

func end():
	print("enemy_turn.end")
	battle_board.reset()

func _on_timer():
	print("enemy_turn._on_timer")
	
	if next != null:
		next.call()
	
	print("no next")

func _target():
	target = enemy.threat_table.target
	
	target.highlight = true
	
	next = _damage
	
	battle_board.buttons.bind_actions(target, target.defenses)

func on_action_button_pressed(action_button: ActionButton, _index:int):
	if action_button.action.defend(30, enemy, target):
		var dmg = action_button.action.reduce(randi_range(2,4))
		battle_board.combat_text.show_combat_text(battle_board.pcs.get_character_ui(target).center, "%s" % dmg)
		target.take_damage(dmg)
	else:
		battle_board.combat_text.show_combat_text(battle_board.pcs.get_character_ui(target).center, "MISS")
	
	battle_board.buttons.clear()
	
	next = _end
	_timer.start()

func on_action_button_entered(action_button: ActionButton):
	action_button.action.render_tooltip_full(target, enemy, battle_board.tooltip)
	battle_board.tooltip.visible = true

func on_action_button_exited(_action_button: ActionButton):
	battle_board.tooltip.visible = false

func _damage():
	battle_board.combat_text.show_combat_text(battle_board.pcs.get_character_ui(target).center, "3")
	target.take_damage(3)
	
	next = _end
	_timer.start()

func _end():
	battle_board.reset()
	on_end_turn.emit()
