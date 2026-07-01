class_name CombatText

extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

var to_play: String
var text: String

func _ready():
	label.text = text

func finish():
	self.queue_free()
