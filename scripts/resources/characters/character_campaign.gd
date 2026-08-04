class_name CharacterCampaign

extends Resource

var base: CharacterBase

var level: int = 0
var xp_needed: int = Global.xp_per_level[0]
var cur_xp: int = 0

var race: Race
var _class: Class
var speed: int
var armor: Armor
var weapon: Weapon
var abilities: Array[Ability]
var available_abilities: Array[Ability]
var traits: Array[Trait]
var available_traits: Array[Trait]
var key_binds: Array[String]
var resources: Dictionary[Resources, float] = {
	Resources.HEALTH: 10,
	Resources.ARMOR: 0,
	Resources.DURABILITY: 0,
	Resources.SHIELDING: 0,
	Resources.STAMINA: 5,
	Resources.MANA: 5,
}
var dodge: int

var recovery: Dictionary[Resources, float] = {
		Resources.HEALTH: 0,
		Resources.ARMOR: 0,
		Resources.DURABILITY: 0,
		Resources.SHIELDING: 0,
		Resources.STAMINA: 3,
		Resources.MANA: 0,
}

var attributes: Dictionary[Attributes, float] = {
	Attributes.STRENGTH: 1,
	Attributes.AGILITY: 1,
	Attributes.MAGIC: 1,
	Attributes.ARMOR: 0,
	Attributes.SPELLHIT: 0,
	Attributes.DODGE: 0,
	Attributes.THREAT: 0,
	Attributes.SUBTLETY: 0,
	Attributes.ATTACKHIT: 0,
	Attributes.BLOCK_CHANCE: 0,
	Attributes.BLOCK_VALUE: 0,
	Attributes.DURABILITY_SCALE: 0.5,
}

enum Resources{ HEALTH, DURABILITY, SHIELDING, STAMINA, MANA, ARMOR }

enum Attributes { 
	STRENGTH, AGILITY, MAGIC, 
	ARMOR,
	SPELLHIT,
	DODGE,
	THREAT,
	SUBTLETY,
	ATTACKHIT,
	BLOCK_CHANCE,
	BLOCK_VALUE,
	DURABILITY_SCALE,
}

func _init(_base: CharacterBase, attack: Ability):
	base = _base
	
	abilities = []
	abilities.resize(4)
	
	traits = []
	traits.resize(4)
	
	set_race(_base.race)
	set_class(_base.class_)
	
	equip_armor(_base.armor)
	equip_weapon(_base.weapon)
	traits[0] = _base.trait_
	available_traits.append(_base.trait_)
	abilities[0] = attack
	available_abilities.append(attack)
	abilities[1] = _base.ability
	available_abilities.append(_base.ability)

func get_character_battle() -> CharacterBattle:
	return CharacterBattle.new(self)

func get_keybinds() -> Array:
	return Global.action_button_map[base.index]

func get_body() -> Texture2D:
	return race.body_textures[armor.armor_class]

func get_head() -> Texture2D:
	return race.head_textures[_class]

func equip_trait(index: int, _trait: Trait):
	pass

func equip_ability(index: int, _ability: Ability):
	pass

func equip_armor(_armor: Armor):
	armor = _armor
	if armor != null:
		armor.equip(self)

func unequip_armor():
	armor.unequip(self)
	armor = null

func equip_weapon(_weapon: Weapon):
	weapon = _weapon
	if weapon != null:
		weapon.equip(self)

func unequip_weapon():
	weapon.unequip(self)
	weapon = null

func add_ability(ability: Ability):
	available_abilities.append(ability)
	var index = 0
	for cur in abilities:
		if cur == null: break
		index += 1
	if index < abilities.size():
		abilities[index] = ability

func add_trait(_trait: Trait):
	available_traits.append(_trait)
	var index = 0
	for cur in traits:
		if cur == null: break
		index += 1
	if index < traits.size():
		traits[index] = _trait

func level_up():
	if cur_xp >= xp_needed:
		cur_xp = cur_xp - xp_needed
		level += 1
		xp_needed = Global.xp_per_level[level]
	
	if _class.levels.has(level):
		for cur in _class.levels[level].attributes:
			attributes[cur] += _class.levels[level].attributes[cur]
		
		for cur in _class.levels[level].resources:
			resources[cur] += _class.levels[level].resources[cur]
		
		for cur in _class.levels[level].recovery:
			recovery[cur] += _class.levels[level].recovery[cur]
	
	if race.levels.has(level):
		for cur in race.levels[level].attributes:
			attributes[cur] += race.levels[level].attributes[cur]
		
		for cur in race.levels[level].resources:
			resources[cur] += race.levels[level].resources[cur]
		
		for cur in race.levels[level].recovery:
			recovery[cur] += race.levels[level].recovery[cur]

func set_race(_race: Race):
	race = _race
	
	attributes[Attributes.STRENGTH] += race.strength
	attributes[Attributes.AGILITY] += race.agility
	attributes[Attributes.MAGIC] += race.magic
	
	resources[Resources.HEALTH] += race.health
	resources[Resources.DURABILITY] += race.durability
	resources[Resources.STAMINA] += race.stamina
	resources[Resources.MANA] += race.mana
	
	recovery[Resources.HEALTH] += race.health_recovery
	recovery[Resources.STAMINA] += race.stamina_recovery
	recovery[Resources.MANA] += race.mana_recovery
	
	attributes[Attributes.ARMOR] += race.armor
	attributes[Attributes.DODGE] += race.dodge
	
	attributes[Attributes.THREAT] += race.threat

func set_class(class_: Class):
	_class = class_
	
	attributes[Attributes.STRENGTH] += _class.strength
	attributes[Attributes.AGILITY] += _class.agility
	attributes[Attributes.MAGIC] += _class.magic
	
	resources[Resources.HEALTH] += _class.health
	resources[Resources.DURABILITY] += _class.durability
	resources[Resources.STAMINA] += _class.stamina
	resources[Resources.MANA] += _class.mana
	
	recovery[Resources.HEALTH] += _class.health_recovery
	recovery[Resources.STAMINA] += _class.stamina_recovery
	recovery[Resources.MANA] += _class.mana_recovery
	
	attributes[Attributes.ARMOR] += _class.armor
	attributes[Attributes.DODGE] += _class.dodge
	
	attributes[Attributes.THREAT] += _class.threat
	attributes[Attributes.SUBTLETY] += _class.subtlety
