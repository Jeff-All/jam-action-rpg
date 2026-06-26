extends VBoxContainer

@export var flip: bool = false

var enemy_pane: EnemyPane

func _ready():
	enemy_pane = $EnemyPane
	
	enemy_pane.flip = flip

func _on_mouse_entered():
	enemy_pane.texture_rect.material.set_shader_parameter("index", 1)

func _on_mouse_exited():
	enemy_pane.texture_rect.material.set_shader_parameter("index", 0)
