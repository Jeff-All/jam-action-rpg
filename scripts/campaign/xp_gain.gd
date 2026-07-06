class_name XPGain

extends Control

signal on_continue()

var xp_windows: Array[CharacterXPWindow]

func _ready():
	for cur in $CharacterXPWindows.get_children():
		xp_windows.append(cur)

func hide_windows():
	for cur in xp_windows:
		cur.visible = false

func setup(party: Array[CharacterCampaign]):
	hide_windows()
	var index = 0
	for cur in party:
		if index > xp_windows.size():
			break
		xp_windows[index].character = cur
		xp_windows[index].visible = true
		index += 1

func _on_continue_pressed(_simple_button: SimpleButton):
	on_continue.emit()
