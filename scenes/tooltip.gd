class_name ToolTip

extends PanelContainer

@export var offset: Vector2

var text: String:
	set(value):
		$MarginContainer/Text.text = value

func _process(_delta):
	set_position(get_global_mouse_position() + offset)
	Input.set_default_cursor_shape(Input.CURSOR_CAN_DROP)
