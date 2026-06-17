extends PanelContainer

var value

func _ready():
	$PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Accept.disabled = false
	$PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Cancel.disabled = false

func populate(_value):
	value = _value
	$PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Accept.disabled = false
	$PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Cancel.disabled = false
	
	$PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Title/Title.text = value.get_header()
	
	$PanelContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Description/MarginContainer/RichTextLabel.text = value.get_description()
