class_name CharacterCampaign

extends Resource

var base: CharacterBase

var level: int = 0
var xp_needed: int = 10
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
var resources: Dictionary[Resources, int] = {
	Resources.HEALTH: 10,
	Resources.ARMOR: 0,
	Resources.DURABILITY: 0,
	Resources.SHIELDING: 0,
	Resources.STAMINA: 5,
	Resources.MANA: 5,
}

var recovery: Dictionary[Resources, int] = {
		Resources.HEALTH: 0,
		Resources.ARMOR: 0,
		Resources.DURABILITY: 0,
		Resources.SHIELDING: 0,
		Resources.STAMINA: 3,
		Resources.MANA: 0,
}

var attributes: Dictionary[Attributes, int] = {
	Attributes.STRENGTH: 1,
	Attributes.AGILITY: 1,
	Attributes.MANA: 1,
}

enum Resources{ HEALTH, ARMOR, DURABILITY, SHIELDING, STAMINA, MANA }

enum Attributes { STRENGTH, AGILITY, MANA }

func _init(_base: CharacterBase, attack: Ability):
	base = _base
	
	abilities = []
	abilities.resize(4)
	
	traits = []
	traits.resize(4)
	
	set_race(_base.race)
	set_class(_base.class_)
	
	_class = _base.class_
	armor = _base.armor
	weapon = _base.weapon
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

func equip_armor(_armor: Armor) -> Armor:
	return null

func equip_weapon(_weapon: Weapon) -> Weapon:
	return null

func add_ability(ability: Ability):
	available_abilities.append(ability)
	var index = 0
	for cur in abilities:
		if cur == null:
			break
		index += 1
	if index < abilities.size():
		abilities[index] = ability

func level_up():
	if cur_xp >= xp_needed:
		cur_xp = cur_xp - xp_needed
		xp_needed = xp_needed * 2

func set_race(_race: Race):
	race = _race
	
	attributes[Attributes.STRENGTH] += race.strength
	attributes[Attributes.AGILITY] += race.agility
	attributes[Attributes.MANA] += race.mana
	
	resources[Resources.HEALTH] += race.health
	resources[Resources.ARMOR] += race.armor
	resources[Resources.DURABILITY] += race.durability
	resources[Resources.STAMINA] += race.stamina
	resources[Resources.MANA] += race.mana
	
	recovery[Resources.HEALTH] += race.health_recovery
	recovery[Resources.STAMINA] += race.stamina_recovery
	recovery[Resources.MANA] += race.mana_recovery

func set_class(class_: Class):
	_class = class_
	
	attributes[Attributes.STRENGTH] += _class.strength
	attributes[Attributes.AGILITY] += _class.agility
	attributes[Attributes.MANA] += _class.mana
	
	resources[Resources.HEALTH] += _class.health
	resources[Resources.ARMOR] += _class.armor
	resources[Resources.DURABILITY] += _class.durability
	resources[Resources.STAMINA] += _class.stamina
	resources[Resources.MANA] += _class.mana
	
	recovery[Resources.HEALTH] += _class.health_recovery
	recovery[Resources.STAMINA] += _class.stamina_recovery
	recovery[Resources.MANA] += _class.mana_recovery
