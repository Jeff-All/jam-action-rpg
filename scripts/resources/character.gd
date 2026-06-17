class_name Character
extends Resource

signal on_death(character)

signal on_cur_durability_change(character)
signal on_cur_health_change(character)
signal on_cur_stamina_change(character)
signal on_cur_mana_change(character)

signal on_take_damage(damage: int)
signal on_heal(amount: int)
signal on_defend_attack()

signal on_turn_order_mouse_enter(character)
signal on_turn_order_mouse_exit(character)

signal on_set_active(character, value: bool)
signal on_set_highlight(character, value: bool)

signal on_apply_buff(buff: BuffActive)

enum Attribute { STRENGTH, AGILITY, MAGIC }
enum CharacterResource { DURABILITY, HEALTH, STAMINA, MANA}

static func get_attribute_name(attribute: Attribute) -> String:
	match attribute:
		Attribute.STRENGTH: 
			return "Strength"
		Attribute.AGILITY: 
			return "Agility"
		Attribute.MAGIC: 
			return "Magic"
	return ""

static func get_resource_name(resource: CharacterResource) -> String:
	match resource:
		CharacterResource.DURABILITY:
			return "Durability"
		CharacterResource.HEALTH:
			return "Health"
		CharacterResource.STAMINA:
			return "Stamina"
		CharacterResource.MANA:
			return "Mana"
	return ""

@export var name: String:
	get():
		return _get_name()

func _get_name() -> String:
	return "default name"

@export var count: int

@export var texture: Texture2D

@export var strength: int
@export var agility: int
@export var magic: int

@export var armor: int
@export var max_durability: int
@export var max_health: int
@export var max_stamina: int
@export var max_mana: int

@export var cur_durability: int:
	set = _set_cur_durability
@export var cur_health: int:
	set = _set_cur_health
@export var cur_stamina: int:
	set = _set_cur_stamina
@export var cur_mana: int:
	set = _set_cur_mana

@export var health_recovery: int
@export var stamina_recovery: int
@export var mana_recovery: int

@export var attack: int
@export var defense: int

@export var weapon: Weapon

var dead: bool:
	get():
		return cur_health <= 0

var actions: Array[ActionState]:
	get = _get_actions

func _get_actions() -> Array[ActionState]:
	return []

func get_attribute(attribute: Attribute):
	match attribute:
		Attribute.STRENGTH: return strength
		Attribute.AGILITY: return agility
		Attribute.MAGIC: return magic

func get_resource(resource: CharacterResource) -> int:
	match resource:
		CharacterResource.DURABILITY: return cur_durability
		CharacterResource.HEALTH: return cur_health
		CharacterResource.STAMINA: return cur_stamina
		CharacterResource.MANA: return cur_mana
	return 0

func set_resource(resource: CharacterResource, value: int):
	match resource:
		CharacterResource.DURABILITY: cur_durability = min(max_durability, value)
		CharacterResource.HEALTH: cur_health = min(max_health, value)
		CharacterResource.STAMINA: cur_stamina = min(max_stamina, value)
		CharacterResource.MANA: cur_mana = min(max_mana, value)

func modify_resource(resource: CharacterResource, value: int):
	match resource:
		CharacterResource.DURABILITY: cur_durability = min(max_durability, cur_durability + value)
		CharacterResource.HEALTH: cur_health = min(max_health, cur_health + value)
		CharacterResource.STAMINA: cur_stamina = min(max_stamina, cur_stamina + value)
		CharacterResource.MANA: cur_mana = min(max_mana, cur_mana + value)

func defended_attack():
	on_defend_attack.emit()

func heal(amount: int):
	var amount_healed = min(amount, max_health - cur_health)
	cur_health = min(max_health, cur_health + amount)
	
	on_heal.emit(amount_healed)

func take_damage(attacker: Character, damage: int):
	var actual_damage = damage
	if cur_durability > 0:
		actual_damage -= armor
		if damage >= armor:
			cur_durability -= 1
	
	actual_damage = max(0, actual_damage)
	
	cur_health -= actual_damage
	
	on_take_damage.emit(actual_damage)

func _set_cur_durability(new_durability: int):
	if cur_durability != new_durability:
		cur_durability = min(max_durability, max(0, new_durability))
	on_cur_durability_change.emit(self)

func _set_cur_health(new_health: int):
	var bound_health = max(0, new_health)
	if cur_health != bound_health:
		cur_health = bound_health
		on_cur_health_change.emit(self)
	if cur_health <= 0:
		print("character %s death" % name)
		_on_death()

func prepare_for_battle():
	pass

func _on_death():
	interrupt_cast()
	
	on_death.emit(self)

func _set_cur_stamina(new_stamina: int):
	if cur_stamina != new_stamina:
		cur_stamina = min(max_stamina, max(0, new_stamina))
		on_cur_stamina_change.emit(self)

func _set_cur_mana(new_mana: int):
	if cur_mana != new_mana:
		cur_mana = min(max_mana, max(0, new_mana))
		on_cur_mana_change.emit(self)

var active: bool:
	set(value):
		_active = value
		on_set_active.emit(self, _active)

var _active: bool = false

var highlight: bool:
	set(value):
		_highlight = value
		on_set_highlight.emit(self, value)

var _highlight: bool = false

func turn_order_mouse_enter(_ui: TurnOrderCharacter):
	on_turn_order_mouse_enter.emit(self)

func turn_order_mouse_exit(_ui :TurnOrderCharacter):
	on_turn_order_mouse_exit.emit(self)

func end_turn():
	cur_health = cur_health + health_recovery
	cur_mana = cur_mana + mana_recovery
	cur_stamina = cur_stamina + stamina_recovery


signal on_start_cast(action: Action)
signal on_update_cast(progress: float)
signal on_finish_cast(character: Character)

var cur_cast: float = 0.0
var action_being_cast: ActionState = null
var target_of_cast: Character = null

func instant_cast(action: ActionState, target: Character):
	cur_cooldown = cur_cooldown_max
	if action.base is AttackAction:
		cur_attack_cooldown = weapon.speed
	action.start_cooldown()
	action.update_cooldowns(0.0, 1.0, cur_cooldown, cur_attack_cooldown/weapon.speed, cur_attack_cooldown)
	action.base.apply(action.buffs,self, target)

func start_cast(action: ActionState, target: Character):
	cur_cast = 0.0
	action_being_cast = action
	target_of_cast = target
	on_start_cast.emit(action)

func update_cast(delta: float):
	cur_cast += delta
	if target_of_cast.dead:
		interrupt_cast()
	else: if cur_cast > action_being_cast.base.get_cast_time(self):
		finish_cast()
	else:
		on_update_cast.emit(cur_cast / action_being_cast.base.get_cast_time(self))

func finish_cast():
	cur_cast = 0.0
	action_being_cast.base.apply(action_being_cast.buffs, self, target_of_cast)
	
	action_being_cast = null
	target_of_cast = null
	on_finish_cast.emit(self)

func interrupt_cast():
	cur_cast = 0.0
	action_being_cast = null
	target_of_cast = null
	on_finish_cast.emit(self)

func process_tick(delta: float):
	if !dead:
		update_recover(delta)
		if action_being_cast != null:
			update_cast(delta)
		update_cooldowns(delta)
		update_buffs(delta)

var cur_recover: float = 0.0

func update_recover(delta: float):
	cur_recover += delta
	if cur_recover > 3.0:
		recover()

func recover():
	cur_recover = fmod(cur_recover, 3.0)
	modify_resource(CharacterResource.STAMINA, stamina_recovery)
	modify_resource(CharacterResource.HEALTH, health_recovery)

var cur_cooldown_max: float = 1.0
var cur_cooldown: float = 0.0
var cur_attack_cooldown: float = 0.0

func update_cooldowns(delta: float):
	cur_cooldown = maxf(0.0, cur_cooldown - delta)
	cur_attack_cooldown = maxf(0.0, cur_attack_cooldown - delta)
	for cur_action in actions:
		cur_action.update_cooldowns(delta, cur_cooldown/cur_cooldown_max, cur_cooldown, cur_attack_cooldown/weapon.speed, cur_attack_cooldown)

var buffs: Array[BuffActive]

var cur_buff_max: float = 1.0
var cur_buff: float = 0.0

func apply_buff(buff: BuffActive):
	print("Character.apply_buff")
	buffs.append(buff)
	on_apply_buff.emit(buff)

func end_buffs(to_end: Array[BuffActive]):
	for cur in to_end:
		end_buff(cur)

func end_buff(buff: BuffActive):
	buffs.remove_at(buffs.find(buff))
	buff.end()

func update_buffs(delta: float):
	cur_buff += delta
	if cur_buff > cur_buff_max:
		var buffs_to_end: Array[BuffActive]
		cur_buff = fmod(cur_buff, cur_buff_max)
		for buff in buffs:
			if !buff.tick():
				buffs_to_end.append(buff)
		end_buffs(buffs_to_end)
