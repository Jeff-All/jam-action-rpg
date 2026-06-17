class_name GridSelector

extends PanelContainer

signal on_selected(value)

var slot_buttons: Array[SlotButton]
var tuples: Array[Array] 
var cur_page: int = 0
var max_page: int = 0

func _ready():
	for cur in $Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/GridContainer.get_children():
		cur.on_pressed.connect(_on_slot_button_pressed)
		slot_buttons.append(cur)
		cur.disable()

func fill(_tuples: Array):
	cur_page = 0
	@warning_ignore("integer_division")
	max_page = _tuples.size() / (slot_buttons.size()+1)
	cur_page = 0
	tuples.clear()
	for cur_tuple in _tuples:
		tuples.append(cur_tuple)
	fill_page()
	fill_page_label()

func fill_page_label():
	$Grid/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/PageLabel.text = "%s/%s" % [cur_page + 1, max_page + 1]
	
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

func fill_page():
	clear_buttons()
	var cur_index = 0
	var tuple_start_index = cur_page * slot_buttons.size()
	while cur_index < slot_buttons.size() && cur_index + tuple_start_index < tuples.size():
		var cur_tuple = tuples[cur_index + tuple_start_index]
		var slot_button = slot_buttons[cur_index]
		slot_button.fill(cur_tuple[0], cur_tuple[1])
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
	$Selector.populate(button.value)
	$Selector.visible = true

func _on_accept_on_pressed(_button: SimpleButton):
	on_selected.emit($Selector.value)
	$Selector.visible = false
	visible = false

func _on_decline_on_pressed(_button: SimpleButton):
	$Selector.visible = false
