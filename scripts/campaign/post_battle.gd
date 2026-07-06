class_name PostBattle

extends Control

signal on_end()

var xp_gain: XPGain

func _ready():
	xp_gain = $XPGain

func start(party: Array[CharacterCampaign]):
	xp_gain.setup(party)
	xp_gain.visible = true

func _xp_gain_on_continue():
	on_end.emit()
