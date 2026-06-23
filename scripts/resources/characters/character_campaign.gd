class_name CharacterCampaign

extends Resource

var base: CharacterBase

var race: Race
var _class: Class
var armor: Armor
var weapon: Weapon
var abilities: Array[Ability]
var available_abilities: Array[Ability]
var traits: Array[Trait]
var available_traits: Array[Trait]
var key_binds: Array[String]

func _init(_base: CharacterBase):
	base = _base
	
	abilities = []
	abilities.resize(4)
	
	traits = []
	traits.resize(4)

func get_character_battle() -> CharacterBattle:
	return CharacterBattle.new(self)

func get_keybinds() -> Array:
	return Global.action_button_map[base.index]

func get_body() -> Texture2D:
	return race.body_textures[armor.armor_class]

func get_head() -> Texture2D:
	return race.head_textures[_class]
