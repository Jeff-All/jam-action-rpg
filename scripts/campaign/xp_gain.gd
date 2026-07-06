class_name XPGain

extends Control

signal on_continue()

var xp_windows: Array[CharacterXPWindow]
var level_up: LevelUp

func _ready():
	level_up = $LevelUp
	
	for cur in $CharacterXPWindows.get_children():
		xp_windows.append(cur)

func reset():
	level_up.visible = false
	hide_windows()

func hide_windows():
	for cur in xp_windows:
		cur.visible = false

func setup(party: Array[CharacterCampaign]):
	reset()
	var index = 0
	for cur in party:
		if index > xp_windows.size():
			break
		xp_windows[index].character = cur
		xp_windows[index].visible = true
		index += 1

func _on_continue_pressed(_simple_button: SimpleButton):
	on_continue.emit()

func _character_xp_window_on_level_up(character: CharacterCampaign):
	level_up.set_up(character, character._class.levels[character.level + 1].abilities)
	level_up.visible = true

func _level_up_on_ability_select(character: CharacterCampaign, ability: Ability):
	character.add_ability(ability)
	character.level_up()
	level_up.visible = false
	for cur in xp_windows:
		if cur.character == character:
			cur.update()
			break
