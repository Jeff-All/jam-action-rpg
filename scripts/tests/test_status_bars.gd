extends MarginContainer

var status_bars: StatusBars

func _ready():
	status_bars = $MarginContainer/StatusBars

func _on_width_value_changed(value):
	$MarginContainer.custom_minimum_size.x = value

func _on_cur_health_changed(value):
	status_bars.cur_health = value

func _on_cur_shield_changed(value):
	status_bars.cur_shield = value

func _on_cur_armor_changed(value):
	status_bars.cur_armor= value

func _on_cur_durability_changed(value):
	status_bars.cur_durability = value

func _on_cur_stamina_changed(value):
	status_bars.cur_stamina = value

func _on_cur_mana_changed(value):
	status_bars.cur_mana = value

func _on_max_health_changed(value):
	status_bars.max_health = value

func _on_max_durability_changed(value):
	status_bars.max_durability = value

func _on_max_stamina_changed(value):
	status_bars.max_stamina = value

func _on_max_mana_changed(value):
	status_bars.max_mana = value
