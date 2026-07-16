class_name ChronoController

extends Control

signal on_process(delta: float)
signal on_process_step()

var cur_step: float = 0.0
var paused: bool = true

func reset():
	cur_step = 0.0
	paused = true

func _process(delta):
	if !paused:
		cur_step += delta
		
		if cur_step > Global.step_size:
			cur_step = fmod(cur_step, Global.step_size)
			on_process_step.emit()
		
		on_process.emit(delta)

func play_pause() -> bool:
	paused = !paused
	return paused
