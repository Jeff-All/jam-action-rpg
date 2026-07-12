class_name PCUI

extends Node

signal on_pressed(PCUI)
signal on_ability_pressed(PCUI, AbilityButton)
signal on_death(pc: PCUI)
signal on_resources_consumed(pc: PCUI, cost: Dictionary[CharacterCampaign.Resources, int])

@export var flip: bool = false

var _material: ShaderMaterial
var portrait: CharacterPortrait
var _character: CharacterBattle
var status_bars: StatusBars
var mouse_panel: Panel

var abilities: Array[AbilityButton]
var buffs: Array[PCBuff]

var _clickable: bool = false
var _hover: bool = false
var _left_down: bool = false

var _dead: bool = false

var dead: bool:
	set(value):
		_dead = value
	get:
		return _dead

var character: CharacterBattle:
	set(value):
		_character = value
		if _character == null:
			return
		portrait.character = value.character_campaign
		set_abilities()
		bind_status_bars()
		bind_character()
		
		_dead = false
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

var texture: Texture2D:
	get:
		return portrait.view_port.get_texture()

var dodge: int:
	get:
		return _character.character_campaign.dodge

func _ready():
	_material = $VBoxContainer/CharacterPortrait.get_shader()
	portrait = $VBoxContainer/CharacterPortrait
	status_bars = $VBoxContainer/StatusBars
	mouse_panel = $VBoxContainer/CharacterPortrait/MarginContainer2/Panel
	
	for cur in $VBoxContainer/PanelContainer/PanelContainer/MarginContainer/AbilityButtons.get_children():
		abilities.append(cur)
	
	for cur in $VBoxContainer/CharacterPortrait/Buffs.get_children():
		buffs.append(cur)
	
	portrait.flip(flip)
	
	await get_tree().process_frame

func reset():
	clear_abilities()
	clear_buffs()
	unbind_character()
	portrait.character = null
	character = null
	dead = false
	
	for cur in abilities:
		cur.reset()
	
	for cur in buffs:
		cur.reset()
	
	portrait.animation_player.play("RESET")

func process_animations(delta: float):
	for cur in abilities:
		cur.process_animations(delta)
	
	for cur in buffs:
		if cur._buff != null:
			cur.process_animations(delta)

func process_step():
	process_recovery()
	
	for cur in abilities:
		cur.process_step()
	
	for cur in buffs:
		if cur._buff != null:
			cur.process_step(self)

func process_recovery():
	if character != null:
		for cur in character.character_campaign.recovery:
			if character.character_campaign.recovery[cur] > 0:
				character.resources[cur].recover(Global.step_size / Global.tick_size)
				#character.add_cur_resource(cur, (character.character_campaign.recovery[cur] * Global.step_size) / Global.tick_size)

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
		cur.ability = null

func clear_buffs():
	for cur in buffs:
		cur.visible = false
		cur.buff = null

func bind_status_bars():
	status_bars.max_health = _character.character_campaign.resources[CharacterCampaign.Resources.HEALTH]
	status_bars.cur_health = _character.character_campaign.resources[CharacterCampaign.Resources.HEALTH]
	status_bars.max_durability = _character.character_campaign.resources[CharacterCampaign.Resources.DURABILITY]
	status_bars.cur_durability = _character.character_campaign.resources[CharacterCampaign.Resources.DURABILITY]
	status_bars.max_stamina= _character.character_campaign.resources[CharacterCampaign.Resources.STAMINA]
	status_bars.cur_stamina = _character.character_campaign.resources[CharacterCampaign.Resources.STAMINA]
	status_bars.max_mana = _character.character_campaign.resources[CharacterCampaign.Resources.MANA]
	status_bars.cur_mana = _character.character_campaign.resources[CharacterCampaign.Resources.MANA]
	
	status_bars.cur_armor = _character.character_campaign.attributes[CharacterCampaign.Attributes.ARMOR]

func bind_character():
	_character.on_resources_consumed.connect(_on_resources_consumed)
	_character.on_cur_resource_change.connect(_on_cur_resource_change)
	_character.on_attribute_change.connect(_on_attribute_change)
	_character.on_death.connect(_on_death)

func unbind_character():
	if _character != null:
		_character.on_resources_consumed.disconnect(_on_resources_consumed)
		_character.on_cur_resource_change.disconnect(_on_cur_resource_change)
		_character.on_attribute_change.disconnect(_on_attribute_change)
		_character.on_death.disconnect(_on_death)

func _on_attribute_change(attribute: CharacterCampaign.Attributes, value: int):
	match attribute:
		CharacterCampaign.Attributes.ARMOR:
			status_bars.cur_armor = value

func _on_cur_resource_change(resource: CharacterCampaign.Resources, value: int):
	match resource:
		CharacterCampaign.Resources.HEALTH:
			status_bars.cur_health = value
		CharacterCampaign.Resources.ARMOR:
			status_bars.cur_armor = value
		CharacterCampaign.Resources.DURABILITY:
			status_bars.cur_durability = value
		CharacterCampaign.Resources.STAMINA:
			status_bars.cur_stamina = value
		CharacterCampaign.Resources.MANA:
			status_bars.cur_mana = value
	check_if_can_afford_abilities()

func take_damage(value: int, ignore_armor: bool = false):
	var armor = character.attributes[CharacterCampaign.Attributes.ARMOR].adjusted
	var durability = character.resources[CharacterCampaign.Resources.DURABILITY].cur
	if armor > 0 && durability > 0 && !ignore_armor:
		durability -= ceil(min(value, armor) / 2)
		if armor <= value:
			value = value - armor
		else:
			value = 0
	spawn_combat_text("%s" % value)
	var health = character.resources[CharacterCampaign.Resources.HEALTH].cur
	character.set_cur_resource(CharacterCampaign.Resources.HEALTH, health - value)
	character.set_cur_resource(CharacterCampaign.Resources.DURABILITY, durability)
	if durability <= 0:
		character.attributes[CharacterCampaign.Attributes.ARMOR].override = 0

func check_if_can_afford_abilities():
	for cur in abilities:
		if cur.ability != null:
			var can_afford = character.can_afford(cur.ability)
			cur.can_afford = can_afford

func _ability_button_on_pressed(button: AbilityButton, _index: int):
	on_ability_pressed.emit(self, button)

func trigger_base_cooldown():
	for cur in abilities:
		if cur.ability != null:
			if cur.ability.on_base_cooldown:
				cur.start_cooldown(Global.base_cooldown)

func trigger_attack_cooldown():
	for cur in abilities:
		if cur.ability is AbilityAttack:
			if cur.ability.on_attack_cooldown:
				cur.start_cooldown(character.character_campaign.weapon.speed)

func spawn_combat_text(text: String):
	var combat_text = Global.combat_text.instantiate() as CombatText
	mouse_panel.add_child(combat_text)
	combat_text.label.text = text
	combat_text.animation.play("float")

func _on_death(_char: CharacterBattle):
	dead = true
	on_death.emit(self)
	for cur in abilities:
		cur.clickable = false
	portrait.animation_player.play("Death")

func apply_buff(buff: BuffPC):
	if overwrite_buff(buff):
		return
	buff.apply(self)
	for cur in buffs:
		if cur._buff == null:
			cur.start_buff(self, buff)
			return

func overwrite_buff(buff: BuffPC) -> bool:
	for cur in buffs:
		if cur.buff != null:
			if cur.buff.name == buff.name:
				cur.animation_player.stop(true)
				cur.animation_player.play()
				return true
	return false

func _pc_buff_on_duration_end(buff: PCBuff):
	buff._buff.remove(self)
	buff.visible = false
	buff.buff = null

func has_buff(buff: BuffPC) -> bool:
	for cur in buffs:
		if cur.buff != null:
			if cur.buff.name == buff.name:
				return true
	return false

func _on_resources_consumed(cost: Dictionary[CharacterCampaign.Resources, int]):
	on_resources_consumed.emit(self, cost)
