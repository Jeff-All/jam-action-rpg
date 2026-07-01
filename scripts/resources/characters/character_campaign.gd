class_name CharacterCampaign

extends Resource

var base: CharacterBase

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
		Resources.STAMINA: 1,
		Resources.MANA: 0,
}

enum Resources{ HEALTH, ARMOR, DURABILITY, SHIELDING, STAMINA, MANA}

func _init(_base: CharacterBase, attack: Ability):
	base = _base
	
	abilities = []
	abilities.resize(4)
	
	traits = []
	traits.resize(4)
	
	set_race(_base.race)
	
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

func set_race(_race: Race):
	race = _race
	
	resources[Resources.HEALTH] += race.health
	resources[Resources.ARMOR] += race.armor
	resources[Resources.DURABILITY] += race.durability
	resources[Resources.STAMINA] += race.stamina
	resources[Resources.MANA] += race.mana

func set_class(class_: Class):
	pass
