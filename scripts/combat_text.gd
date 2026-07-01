class_name CombatTextA

extends Control

@export var prefab: PackedScene

var available: Array[CombatTextInstance]

func show_combat_text(pos: Vector2, text: String):
	print("show_combat_text %s %s" % [pos, text])
	var cur: CombatTextInstance
	if available.size() > 0:
		print("pulling from available")
		cur = available.pop_back()
		
	else:
		print("spawning new")
		cur = _spawn_scene()
		if !cur.is_node_ready():
			await cur.ready
		print("cur.ready")
	print("start animation")
	cur.start_animation(pos, text)

func _spawn_scene() -> CombatTextInstance:
	var spawn = prefab.instantiate()
	var combat_text = spawn as CombatTextInstance
	combat_text.on_animation_end.connect(_animation_ends)
	add_child(combat_text)
	return combat_text

func _scene_ready(pos: Vector2, text: String) -> Callable:
	return func(combat_text: CombatTextInstance):
		print("on_ready")
		combat_text.start_animation(pos, text)

func _animation_ends(combat_text: CombatTextInstance):
	print("_animation_ends")
	combat_text.visible = false
	available.push_back(combat_text)
