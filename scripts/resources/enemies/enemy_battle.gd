class_name EnemyBattle

extends Resource

var base: Enemy

signal on_death()

signal on_health_changed(new_value: int)

var _dead: bool = false
var _cur_health: int

var dead: bool:
	set(value):
		_dead = value
		if _dead:
			on_death.emit()
	get: return _dead
var cur_health: int:
	set(value):
		_cur_health = value
		if _cur_health <= 0:
			_cur_health = 0
			dead = true
		on_health_changed.emit(_cur_health)
	get: return _cur_health
var cur_armor: int
var cur_durability: int
var cur_shields: int
var cur_stamina: int
var cur_mana: int

func _init(_base: Enemy):
	base = _base
	
	cur_health = _base.health
	cur_armor = _base.armor
	cur_durability = _base.durability
	cur_shields = 0
	cur_stamina = _base.stamina
	cur_mana = _base.mana
