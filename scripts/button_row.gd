class_name ButtonRow

extends Container

signal on_action_button_pressed(action_button: ActionButton)
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
		
		_is_ready = true
		
		selectable = _selectable

var _is_ready: bool = false

var _selectable: bool = true

var selectable: bool:
	set(value):
		_selectable = value
		if _is_ready:
			for cur in _action_buttons:
				cur.selectable = _selectable


func _on_action_button_preseed(action_button: ActionButton):
	on_action_button_pressed.emit(action_button)

func _on_action_button_entered(action_button: ActionButton):
	print("br.action button entered")
	on_action_button_entered.emit(action_button)

func _on_action_button_exited(action_button: ActionButton):
	on_action_button_exited.emit(action_button)

func reset():
	for cur in _action_buttons:
		cur.selected = false

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
		_action_buttons[index].update_can_afford()

func lock():
	for cur in _action_buttons:
		cur.locked = true

func update_can_afford():
	for cur in _action_buttons:
		if cur.visible:
			cur.update_can_afford()
