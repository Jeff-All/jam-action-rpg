class_name LevelUp

extends Control

signal on_ability_select(character: CharacterCampaign, ability: Ability)

var abilities: Array[AbilitySelect]
var cur_abilities: Array[SimpleButton]

var character: CharacterCampaign

func _ready():
	for cur in $Abilities.get_children():
		abilities.append(cur)
	
	for cur in $CharacterWindow/Control/TextureRect/CurAbilities.get_children():
		cur_abilities.append(cur)

func reset():
	for cur in abilities:
		cur.visible = false
	
	for cur in cur_abilities:
		cur.visible = false

func set_up(_character: CharacterCampaign, _abilities: Array[Ability]):
	reset()
	character = _character
	var index = 0
	for cur in _abilities:
		if index >= abilities.size():
			break
		abilities[index].abiltity = cur
		abilities[index].visible = true
		index += 1

func _ability_select_on_select(ability: Ability):
	on_ability_select.emit(character, ability)
