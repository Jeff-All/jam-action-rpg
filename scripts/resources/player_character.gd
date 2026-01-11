class_name PlayerCharacter

extends Character

var threat: int

@export var character_class: Class:
	set(value):
		if _class != null && value != _class:
			_remove_class(_class)
		_class = value
		_apply_class(_class)

var _class: Class

func _remove_class(c: Class):
	threat -= c.threat
	
	strength -= c.strength
	agility -= c.agility
	magic -= c.magic
	
	attack -= c.attack
	defense -= c.defense
	
	armor -= c.armor
	max_durability -= c.durability
	max_health -= c.health
	max_stamina -= c.stamina
	max_mana -= c.mana

func _apply_class(c: Class):
	threat += c.threat
	
	strength += c.strength
	agility += c.agility
	magic += c.magic
	
	attack += c.attack
	defense += c.defense
	
	armor += c.armor
	max_durability += c.durability
	max_health += c.health
	max_stamina += c.stamina
	max_mana += c.mana
	
	cur_durability += c.durability
	cur_health += c.health
	cur_stamina += c.stamina
	cur_mana += c.mana

@export var race: Race:
	set(value):
		if _race != null && value != race:
			_race.remove(self)
		_race = value
		_race.apply(self)

var _race: Race

func _get_name() -> String:
	if _race == null or _class == null:
		return "tmp name"
	return "%s.%s" % [_race.name, _class.name]

func _get_actions() -> Array[Action]:
	return _race.actions + _class.actions + Global.default_actions

var defenses: Array[Action]:
	get = _get_defenses

func _get_defenses() -> Array[Action]:
	return _race.defenses + _class.defenses
