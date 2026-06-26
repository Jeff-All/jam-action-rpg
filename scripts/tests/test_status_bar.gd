extends MarginContainer

@export var bar_1_style: StyleBox
@export var bar_2_style: StyleBox

var status_bar: StatusBar

func _ready():
	status_bar = $MarginContainer/StatusBar

func _on_setup_pressed():
	status_bar.bar_styles["bar1"] = bar_1_style
	status_bar.bar_styles["bar2"] = bar_2_style
	
	status_bar.bar_values["bar1"] = $HBoxContainer/VBoxContainer2/cur_value_1.value as int
	status_bar.bar_values["bar2"] = $HBoxContainer/VBoxContainer3/cur_value_2.value as int
	
	status_bar.setup()

func _on_max_value_changed(value):
	status_bar.max_value = value

func _on_cur_value_1_value_changed(value):
	status_bar.set_bar_value("bar1", value)

func _on_cur_value_2_value_changed(value):
	status_bar.set_bar_value("bar2", value)

func _on_width_value_changed(value):
	$MarginContainer.custom_minimum_size.x = value
