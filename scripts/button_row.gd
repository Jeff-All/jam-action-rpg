class_name ButtonRow

extends Container

signal on_action_button_pressed(action_button: ActionButton, index: int)
signal on_action_button_entered(action_button: ActionButton)
signal on_action_button_exited(action_button: ActionButton)

var _action_buttons: Array[ActionButton]

func _ready():
	for cur: ActionButton in $Buttons.get_children(false):
		cur.visible = false
		
		cur.on_pressed.connect(_on_action_button_preseed)
		cur.on_enter.connect(_on_action_button_entered)
		cur.on_exit.connect(_on_action_button_exited)
		
		cur.set_meta("index", _action_buttons.size())
		_action_buttons.append(cur)

func _on_action_button_preseed(action_button: ActionButton):
	on_action_button_pressed.emit(action_button, action_button.get_meta("index"))

func _on_action_button_entered(action_button: ActionButton):
	print("br.action button entered")
	on_action_button_entered.emit(action_button)

func _on_action_button_exited(action_button: ActionButton):
	on_action_button_exited.emit(action_button)

func clear():
	for cur: ActionButton in _action_buttons:
		cur.action = null
		cur.selected = false
		cur.visible = false

func bind_actions(character: Character, actions: Array[Action]):
	clear()
	for index in actions.size():
		if index >= _action_buttons.size(): 
			break
		_action_buttons[index].set_action(character, actions[index])
		_action_buttons[index].visible =  true
		if _action_buttons[index].check_hover():
			mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			mouse_default_cursor_shape = Control.CURSOR_ARROW
		_action_buttons[index].can_afford = actions[index].can_afford(character)
