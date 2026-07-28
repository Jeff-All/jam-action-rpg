class_name LevelUp

extends Control

signal on_ability_select(character: CharacterCampaign, ability: Ability)
signal on_finish_level_up(character: CharacterCampaign)

var ability_container: Control
var trait_container: Control

var abilities: Array[SelectorPane]
var traits: Array[SelectorPane]

var cur_ability_count: int = 0
var cur_trait_count: int = 0

var character: CharacterCampaign

func _ready():
	ability_container = $Abilities
	trait_container = $Traits
	
	for cur in ability_container.get_children():
		abilities.append(cur)
	
	for cur in trait_container.get_children():
		traits.append(cur)

func reset():
	cur_ability_count = 0
	cur_trait_count = 0
	
	ability_container.visible = false
	trait_container.visible = false
	
	for cur in abilities:
		cur.visible = false
	
	for cur in traits:
		cur.visible = false

func set_up(_character: CharacterCampaign, _abilities: Array[Ability], _traits: Array[Trait]) -> bool:
	reset()
	character = _character
	character.level_up()
	
	var index = 0
	for cur in _abilities:
		if index >= abilities.size():
			break
		if _character.available_abilities.has(cur): continue
		abilities[index].value = cur
		abilities[index].visible = true
		index += 1
	
	index = 0
	for cur in _traits:
		if index >= traits.size(): break
		if _character.available_traits.has(cur): continue
		traits[index].value = cur
		traits[index].visible = true
		index += 1
	
	cur_ability_count = _abilities.size()
	cur_trait_count = _traits.size()
	
	if cur_ability_count > 0:
		ability_container.visible = true
	else: if cur_ability_count > 0:
		trait_container.visible = true
	else: return false
	return true

func _ability_select_on_select(ability):
	character.add_ability(ability as Ability)
	
	ability_container.visible = false
	if cur_trait_count > 0:
		trait_container.visible = true
	else: on_finish_level_up.emit(character)

func _trait_select_on_select(_trait):
	character.add_trait(_trait)
	
	trait_container.visible = false
	
	on_finish_level_up.emit(character)
