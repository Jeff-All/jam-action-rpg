class_name StatusBar


extends PanelContainer

var bars_container: Node
var ticks
var base_bar: Panel

var _max_value: int = 1
var bar_styles: Dictionary[String, StyleBox]
var bar_values: Dictionary[String, int]
var bars: Dictionary[String, Panel]

var background_stylebox: StyleBox:
	set(value):
		add_theme_stylebox_override("panel", value)

var max_value: int:
	set(value):
		if value > 0:
			_max_value = value
		update_sizes()

func set_bar_value(id: String, value: int):
	bar_values[id] = value
	
	update_sizes()

func _ready():
	bars_container = $Bars
	ticks = $Ticks
	base_bar = $Bars/BasePanel

func setup():
	for cur in bar_styles:
		build_bar(cur)
	
	update_sizes()

func build_bar(id: String):
	var new_bar = base_bar.duplicate()
	new_bar.add_theme_stylebox_override("panel", bar_styles[id])
	bars[id] = new_bar
	bar_values[id] = 0
	bars_container.add_child(new_bar)
	new_bar.visible = true

func update_sizes():
	for cur in bars:
		var percentage = 0.0
		if bar_values.has(cur):
			percentage = min(1.0, bar_values[cur] as float / _max_value)
		bars[cur].custom_minimum_size.x = percentage * size.x
	
	sort_bars()

func sort_bars():
	var keys = bar_values.keys()
	
	keys.sort_custom(func(a,b):
		return bar_values[a] > bar_values[b]
	)
	
	for cur in keys:
		bars_container.move_child(bars[cur], bars_container.get_child_count() - 1)
