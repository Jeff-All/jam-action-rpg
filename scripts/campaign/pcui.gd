class_name PCUI

extends Node

signal on_pressed(PCUI)
signal on_ability_pressed(PCUI, AbilityButton)

@export var flip: bool = false

var _material: ShaderMaterial
var portrait: CharacterPortrait
var _character: CharacterBattle
var status_bars: StatusBars
var mouse_panel: Panel

var abilities: Array[AbilityButton]

var _clickable: bool = false
var _hover: bool = false
var _left_down: bool = false

var character: CharacterBattle:
	set(value):
		_character = value
		if _character == null:
			return
		portrait.character = value.character_campaign
		set_abilities()
		bind_status_bars()
	get: return _character

var clickable: bool:
	set(value):
		_clickable = value
		if _clickable:
			if _hover:
				_material.set_shader_parameter("index", 2)
			else:
				_material.set_shader_parameter("index", 1)
				mouse_panel.mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
		else:
			_material.set_shader_parameter("index", 0)
			mouse_panel.mouse_default_cursor_shape = Control.CursorShape.CURSOR_ARROW

func _ready():
	_material = $VBoxContainer/CharacterPortrait.get_shader()
	portrait = $VBoxContainer/CharacterPortrait
	status_bars = $VBoxContainer/StatusBars
	mouse_panel = $VBoxContainer/CharacterPortrait/MarginContainer2/Panel
	
	for cur in $VBoxContainer/PanelContainer/PanelContainer/MarginContainer/AbilityButtons.get_children():
		abilities.append(cur)
	
	portrait.flip(flip)
	
	await get_tree().process_frame

func process_animations(delta: float):
	for cur in abilities:
		cur.process_animations(delta)

func process_step():
	process_recovery()
	
	for cur in abilities:
		cur.process_step()

func process_recovery():
	if character != null:
		for cur in character.character_campaign.recovery:
			character.add_cur_resource(cur, (character.character_campaign.recovery[cur] * Global.step_size) / Global.tick_size)

func _on_mouse_entered():
	_hover = true
	if _clickable:
		_material.set_shader_parameter("index", 2)

func _on_mouse_exited():
	_hover = false
	if _clickable:
		_material.set_shader_parameter("index", 1)
	else:
		_material.set_shader_parameter("index", 0)

func _on_gui_input(event):
	if _clickable:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					_left_down = true
					_material.set_shader_parameter("index", 3)
				else:
					_left_down = false
					if _hover:
						_material.set_shader_parameter("index", 2)
						on_pressed.emit(self)


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
	
	_character.on_cur_resource_change.connect(_on_cur_resource_change)

func _on_cur_resource_change(resource: CharacterCampaign.Resources, value: int):
	match resource:
		CharacterCampaign.Resources.HEALTH:
			status_bars.cur_health = value
		CharacterCampaign.Resources.DURABILITY:
			status_bars.cur_durability = value
		CharacterCampaign.Resources.STAMINA:
			status_bars.cur_stamina = value
		CharacterCampaign.Resources.MANA:
			status_bars.cur_mana = value
	check_if_can_afford_abilities()

func check_if_can_afford_abilities():
	for cur in abilities:
		if cur.ability != null:
			var can_afford = character.can_afford(cur.ability)
			cur.can_afford = can_afford

func _ability_button_on_pressed(button: AbilityButton, _index: int):
	on_ability_pressed.emit(self, button)

func trigger_base_cooldown():
	for cur in abilities:
		cur.start_cooldown(Global.base_cooldown)

func trigger_attack_cooldown():
	for cur in abilities:
		if cur.ability is AbilityAttack:
			cur.start_cooldown(character.character_campaign.weapon.speed)
