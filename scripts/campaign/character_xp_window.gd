class_name CharacterXPWindow

extends Control

var xp_bar: StatusBar
var levelup_button: TextureButton
var portrait: CharacterPortrait

var _character: CharacterCampaign
var _max_xp: int
var _xp: int

var character: CharacterCampaign:
	set(value):
		_character = value
		portrait.character = _character
		max_xp = _character.xp_needed
		xp = _character.cur_xp

var max_xp: int:
	set(value):
		_max_xp = value
		xp_bar.max_value = _max_xp
		xp_bar.setup()

var xp: int:
	set(value):
		_xp = value
		if _xp >= _max_xp:
			print("level up")
			levelup_button.visible = true
		else:
			print("show xp: %s / %s" % [_xp, _max_xp])
			levelup_button.visible = false
			xp_bar.set_bar_value("XP", _xp)

func _ready():
	xp_bar = $Control/TextureRect/XPBar
	levelup_button = $Control/LevelUp
	portrait = $CharacterPortrait
	
	levelup_button.visible = false
