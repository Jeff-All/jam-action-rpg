class_name StatusBars

extends HBoxContainer

@export var health_background_style: StyleBox
@export var durability_background_style: StyleBox
@export var stamina_background_style: StyleBox
@export var mana_background_style: StyleBox

@export var health_style: StyleBox
@export var shield_style: StyleBox
@export var armor_style: StyleBox
@export var durability_style: StyleBox
@export var stamina_style: StyleBox
@export var mana_style: StyleBox

var _health: StatusBar
var _durability: StatusBar
var _stamina: StatusBar
var _mana: StatusBar
var _width: float

var width: float:
	set(value):
		print("status_bars.width(pre): %s" % [value])
		if fmod(value, 5.0) != 0:
			value = value - fmod(value, 5.0)
		$PanelContainer/MarginContainer/VBoxContainer.custom_minimum_size.x = value
		$PanelContainer/MarginContainer/VBoxContainer.size.x = value
		_width = value
		_health._width = value
		_durability._width = value
		_stamina._width = value
		_mana._width = value
		print("status_bars.width: %s" % [value])

var max_health: int:
	set(value):
		_health.max_value = value

var max_durability: int:
	set(value):
		_durability.max_value = value

var max_stamina: int:
	set(value):
		_stamina.max_value = value

var max_mana: int:
	set(value):
		_mana.max_value = value

var cur_health: int:
	set(value):
		_health.set_bar_value("health", value)

var cur_shield: int:
	set(value):
		_health.set_bar_value("shield", value)

var cur_armor: int:
	set(value):
		_health.set_bar_value("armor", value)

var cur_durability: int:
	set(value):
		_durability.set_bar_value("durability", value)

var cur_stamina: int:
	set(value):
		_stamina.set_bar_value("stamina", value)

var cur_mana: int:
	set(value):
		_mana.set_bar_value("mana", value)

func _late_ready():
	width = custom_minimum_size.x

func _ready():
	get_tree().root.ready.connect(_late_ready)
	
	_health = $PanelContainer/MarginContainer/VBoxContainer/HealthBar
	_durability = $PanelContainer/MarginContainer/VBoxContainer/DurabilityBar
	_stamina = $PanelContainer/MarginContainer/VBoxContainer/StaminaBar
	_mana = $PanelContainer/MarginContainer/VBoxContainer/ManaBar
	
	_health.background_stylebox = health_background_style
	_durability.background_stylebox = durability_background_style
	_stamina.background_stylebox = stamina_background_style
	_mana.background_stylebox = mana_background_style
	
	_health.bar_styles["health"] = health_style
	_health.bar_styles["shield"] = shield_style
	_health.bar_styles["armor"] = armor_style
	_durability.bar_styles["durability"] = durability_style
	_stamina.bar_styles["stamina"] = stamina_style
	_mana.bar_styles["mana"] = mana_style
	
	_health.setup()
	_durability.setup()
	_stamina.setup()
	_mana.setup()
