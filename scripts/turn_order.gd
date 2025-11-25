class_name TurnOrder

extends PanelContainer

signal on_mouse_enter(turn_order_character: TurnOrderCharacter)
signal on_mouse_exit(turn_order_character: TurnOrderCharacter)

var free_uis: Array[TurnOrderCharacter] = []

var bound_uis: Dictionary[Character, TurnOrderCharacter] = {}
var turn_order: Array[TurnOrderCharacter]

func _ready():
	for cur_ui in $HBoxContainer.get_children():
		cur_ui.visible = false
		free_uis.append(cur_ui)
		cur_ui.on_mouse_enter.connect(_on_mouse_enter)
		cur_ui.on_mouse_exit.connect(_on_mouse_exit)

func add_character(character: Character):
	var cur_ui = free_uis.pop_front()
	cur_ui.character = character
	bound_uis[character] = cur_ui
	cur_ui.visible = true
	turn_order.push_back(cur_ui)
	$HBoxContainer.move_child(cur_ui, $HBoxContainer.get_child_count() - 1)

func cur_turn() -> Character:
	return turn_order[0]._character

func next_turn() -> Character:
	var _first = turn_order.pop_front()
	_first.selected = false
	turn_order.push_back(_first)
	$HBoxContainer.move_child(_first, $HBoxContainer.get_child_count() - 1)
	var new_first = turn_order[0]
	return new_first._character

func roll_initiative(characters: Array) -> TurnOrderCharacter:
	clear()
	
	var initiative_rolls = []
	
	for cur_character in characters:
		if cur_character != null:
			initiative_rolls.append([cur_character, randi_range(0, 100)])
	
	initiative_rolls.sort_custom(func(a,b):
		if a[1] == b[1]:
			return randi_range(0,1) == 0
		return a[1] < b[1]
		)
	
	for cur_tuple in initiative_rolls:
		add_character(cur_tuple[0])
	
	return turn_order[0]

func clear():
	for cur_character in bound_uis:
		var cur_ui = bound_uis[cur_character]
		cur_ui.clear()
		free_uis.append(cur_ui)
	bound_uis.clear()
	
	turn_order.clear()

func _on_mouse_enter(turn_order_character: TurnOrderCharacter):
	on_mouse_enter.emit(turn_order_character)

func _on_mouse_exit(turn_order_character: TurnOrderCharacter):
	on_mouse_exit.emit(turn_order_character)
