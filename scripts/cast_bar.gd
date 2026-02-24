class_name CastBar

extends PanelContainer

var icon: TextureRect
var progress_background: PanelContainer
var progress: Panel

func _ready():
	icon = $MarginContainer/HBoxContainer/Icon
	progress_background = $MarginContainer/HBoxContainer/Progress_Background
	progress = $MarginContainer/HBoxContainer/Progress_Background/Progress
	
	visible = false

func start_cast(action: Action):
	icon.texture = action.texture
	_update_progress_bar(0.0)
	visible = true

func update_cast(_progress: float):
	_update_progress_bar(_progress)

func finish_cast(_character: Character):
	visible = false

func _update_progress_bar(_progress: float):
	progress.custom_minimum_size = Vector2(progress_background.size.x * _progress, 0.0)
