class_name Game

extends Control

var end: bool = false

signal on_victory()
signal on_defeat()

var chrono_controller: ChronoController

func set_up(pcs: PlayerCharacters, encounter: Encounter):
	print("setup")
	chrono_controller = $ChronoController
	
	var enemies = encounter.build_enemies()
	
	enemies.bind_enemies()
	pcs.bind_player_characters()
	pcs.prepare_for_battle()
	
	enemies.build_threat_tables(pcs)
	enemies.prepare_for_battle()
	
	enemies.on_enemies_dead.connect(_on_enemies_dead)
	pcs.on_characters_dead.connect(_on_player_characters_dead)
	
	$InputController/BattleBoard.set_pcs(pcs)
	$InputController/BattleBoard.set_enemies(enemies)
	$InputController/BattleBoard.play_button.visible = true
	
	chrono_controller.set_enemies(enemies)
	chrono_controller.set_pcs(pcs)

func _on_enemies_dead():
	end = true
	print("VICTORY")
	$VictoryOverlay.visible = true
	chrono_controller.stop()
	on_victory.emit()

func _on_player_characters_dead():
	end = true
	print("DEFEAT")
	$DefeatOverlay.visible = true
	chrono_controller.stop()
	on_defeat.emit()

func _on_play_pressed():
	if chrono_controller._paused:
		chrono_controller.start()
		$InputController/BattleBoard.play_button.text = "Pause"
	else :
		chrono_controller.stop()
		$InputController/BattleBoard.play_button.text = "Play"
