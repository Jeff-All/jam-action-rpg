class_name ActionState

extends Resource

var base: Action
var character: Character

var _cur_cooldown: float = 0.0

signal on_update_cooldown(percent: float)

func _init(_base: Action, _character: Character):
	base = _base
	character = _character

func start_cooldown():
	_cur_cooldown = base.get_cooldown(character)

func update_cooldowns(delta: float, char_cooldown_percent: float, char_cooldown_cur: float):
	_cur_cooldown = maxf(0.0, _cur_cooldown - delta)
	var percent = 0.0
	if _cur_cooldown < char_cooldown_cur:
		percent = char_cooldown_percent
	else:
		percent = _cur_cooldown / base.get_cooldown(character)
	on_update_cooldown.emit(percent)
