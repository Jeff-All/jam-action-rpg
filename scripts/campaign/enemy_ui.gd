class_name EnemyUI

extends VBoxContainer

signal on_pressed(EnemyUI)

@export var flip: bool = false

var enemy_pane: EnemyPane
var status_bars: StatusBars
var mouse_panel: Panel
var _material: ShaderMaterial

var _enemy: EnemyBattle
var _clickable: bool = false
var _hover: bool = false
var _left_down: bool = false

var enemy: EnemyBattle:
	set(value):
		_enemy = value
		enemy_pane.enemy = value.base
		bind_status_bars()
	get:
		return _enemy

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
	enemy_pane = $EnemyPane
	status_bars = $EnemyPane/VBoxContainer/StatusBars
	_material = $EnemyPane/Panel/TextureRect.material
	mouse_panel = $EnemyPane/Panel
	
	enemy_pane.flip = flip

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

func bind_status_bars():
	status_bars.max_health = _enemy.base.health
	status_bars.cur_health = _enemy.cur_health
	status_bars.cur_armor = _enemy.cur_armor
	status_bars.max_durability = _enemy.base.durability
	status_bars.cur_durability = _enemy.cur_durability
	status_bars.max_stamina = _enemy.base.stamina
	status_bars.cur_stamina = _enemy.cur_stamina
	status_bars.max_mana = _enemy.base.mana
	status_bars.cur_mana = _enemy.cur_mana
	
	_enemy.on_death.connect(_on_death)
	
	_enemy.on_health_changed.connect(_on_health_change)

func spawn_combat_text(text: String):
		var combat_text = Global.combat_text.instantiate() as CombatText
		mouse_panel.add_child(combat_text)
		combat_text.label.text = text
		combat_text.animation.play("float")

func _on_death():
	enemy_pane.animation_player.play("death")
	$AnimationPlayer.play("death")

func _on_health_change(new_value: int):
	print("_on_health_change(%s)" % new_value)
	status_bars.cur_health = new_value
