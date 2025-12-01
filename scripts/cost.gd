class_name Cost

extends MarginContainer

@export var background: StyleBoxFlat
@export var font_color_default: Color
@export var font_color_locked: Color

var can_afford: bool:
	set(value):
		_can_afford = value
		if _can_afford:
			$Label.add_theme_color_override("font_color", font_color_default)
		else:
			$Label.add_theme_color_override("font_color", font_color_locked)

var _can_afford: bool

var cost: int:
	set(value):
		$Label.text = "%s" % value

func _ready():
	$Background.add_theme_stylebox_override("panel", background)
	$Label.add_theme_color_override("font_color", font_color_default)
