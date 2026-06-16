class_name GridSelector

extends PanelContainer

var slot_buttons: Array[SlotButton]
var tuples: Array[Array] 
var cur_page: int = 0
var max_page: int = 0

func _ready():
	for cur in $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/GridContainer.get_children():
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
	$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/PageLabel.text = "%s/%s" % [cur_page + 1, max_page + 1]

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
