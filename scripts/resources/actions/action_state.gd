class_name ActionState

extends Resource

var base: Action
var character: Character

signal on_update_cooldown(percent: float)

func _init(_base: Action, _character: Character):
	base = _base
	character = _character

func update_cooldowns(_delta: float, char_cooldown_percent: float, _char_cooldown_cur: float):
	print("ActionState.update_cooldowns %s" % char_cooldown_percent)
	on_update_cooldown.emit(char_cooldown_percent)
