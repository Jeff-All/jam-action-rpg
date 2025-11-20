class_name ButtonRow

extends Container

signal on_action_button_pressed(action_button: ActionButton, index: int)

var _action_buttons: Array[ActionButton]

func _ready():
	for cur: ActionButton in $Buttons.get_children(false):
		cur.visible = false
		cur.on_pressed.connect(_on_action_button_preseed)
		cur.set_meta("index", _action_buttons.size())
		_action_buttons.append(cur)

func _on_action_button_preseed(action_button: ActionButton):
	on_action_button_pressed.emit(action_button, action_button.get_meta("index"))

func clear():
	for cur: ActionButton in _action_buttons:
		cur.action = null
		cur.selected = false
		cur.visible = false

func bind_actions(actions: Array[Action]):
	clear()
	for index in actions.size():
		if index >= _action_buttons.size(): 
			break
		_action_buttons[index].action = actions[index]
		_action_buttons[index].visible =  true
