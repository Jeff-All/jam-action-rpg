class_name EnemyBattle

extends Resource

var base: Enemy

var cur_health: int
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
