class_name PCUI

extends Node

@export var flip: bool = false

var _material: ShaderMaterial
var portrait: CharacterPortrait
var _character: CharacterBattle
var status_bars: StatusBars

var abilities: Array[AbilityButton]

var character: CharacterBattle:
	set(value):
		_character = value
		if _character == null:
			return
		portrait.character = value.character_campaign
		set_abilities()
		bind_status_bars()
	get: return _character

func _ready():
	_material = $VBoxContainer/CharacterPortrait.get_shader()
	portrait = $VBoxContainer/CharacterPortrait
	status_bars = $VBoxContainer/StatusBars
	
	for cur in $VBoxContainer/PanelContainer/PanelContainer/MarginContainer/AbilityButtons.get_children():
		abilities.append(cur)
	
	portrait.flip(flip)
	
	await get_tree().process_frame

func _on_mouse_entered():
	_material.set_shader_parameter("index", 1)

func _on_mouse_exited():
	_material.set_shader_parameter("index", 0)

func set_abilities():
	clear_abilities()
	var index = 0
	for cur in _character.character_campaign.abilities:
		if index >= abilities.size():
			break
		abilities[index].ability = cur
		abilities[index].visible = cur != null
		index += 1

func clear_abilities():
	for cur in abilities:
		cur.visible = false

func bind_status_bars():
	status_bars.max_health = _character.character_campaign.resources[CharacterCampaign.Resources.HEALTH]
	status_bars.cur_health = _character.character_campaign.resources[CharacterCampaign.Resources.HEALTH]
	status_bars.cur_armor = _character.character_campaign.resources[CharacterCampaign.Resources.ARMOR]
	status_bars.max_durability = _character.character_campaign.resources[CharacterCampaign.Resources.DURABILITY]
	status_bars.cur_durability = _character.character_campaign.resources[CharacterCampaign.Resources.DURABILITY]
	status_bars.max_stamina= _character.character_campaign.resources[CharacterCampaign.Resources.STAMINA]
	status_bars.cur_stamina = _character.character_campaign.resources[CharacterCampaign.Resources.STAMINA]
	status_bars.max_mana = _character.character_campaign.resources[CharacterCampaign.Resources.MANA]
	status_bars.cur_mana = _character.character_campaign.resources[CharacterCampaign.Resources.MANA]
