class_name GridSelector

extends PanelContainer

signal on_selected(value)

var slot_buttons: Array[SlotButton]
var items: Array
var cur_page: int = 0
var max_page: int = 0
var cur_selected
var selected_item
var page_label
var shadow_offset: Vector2 = Vector2.ZERO

func _ready():
	page_label = $Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/PanelContainer/PageLabel
	
	for cur in $Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/GridContainer.get_children():
		cur.on_pressed.connect(_on_slot_button_pressed)
		slot_buttons.append(cur)
		cur.disable()

func fill(_items: Array, _selected_item, _show: bool = false, _offset: Vector2 = Vector2.ZERO):
	shadow_offset = _offset
	selected_item = _selected_item
	if selected_item == null:
		$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/Details/PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Accept.disabled = true
	cur_page = 0
	@warning_ignore("integer_division")
	max_page = items.size() / (slot_buttons.size()+1)
	cur_page = 0
	items.clear()
	for cur_item in _items:
		items.append(cur_item)
	fill_page()
	fill_page_label()
	visible = _show

func fill_page_label():
	page_label.text = "%s/%s" % [cur_page + 1, max_page + 1]
	
	if cur_page == max_page:
		$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/Right .disabled = true
	else:
		$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/Right.disabled = false
	if cur_page == 0:
		$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/Left.disabled = true
	else:
		$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/Left.disabled = false

func clear_buttons():
	for cur in slot_buttons:
		cur.disable()
		cur.selected = false

func fill_page():
	clear_buttons()
	var cur_index = 0
	var item_start_index = cur_page * slot_buttons.size()
	while cur_index < slot_buttons.size() && cur_index + item_start_index < items.size():
		var cur_item = items[cur_index + item_start_index]
		var slot_button = slot_buttons[cur_index]
		slot_button.fill(cur_item, shadow_offset)
		if cur_item == selected_item:
			cur_selected = slot_button
			slot_button.selected = true
			$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/Details.populate(selected_item)
		slot_button.enable()
		cur_index += 1

func _on_left_pressed(_button: SimpleButton):
	if cur_page > 0:
		cur_page -= 1
	fill_page()
	fill_page_label()

func _on_right_pressed(_button: SimpleButton):
	if cur_page < max_page:
		cur_page += 1
	fill_page()
	fill_page_label()

func _on_slot_button_pressed(button: SlotButton):
	if cur_selected != null:
		cur_selected.selected = false
	cur_selected = button
	selected_item = button.value
	cur_selected.selected = true
	$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/Details.populate(selected_item)
	$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/Details/PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Accept.disabled = false

func _on_accept_on_pressed(_button: SimpleButton):
	on_selected.emit(cur_selected.value)
	visible = false

func _on_decline_on_pressed(_button: SimpleButton):
	visible = false
