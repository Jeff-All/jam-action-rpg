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
	
	enemies.build_threat_tables(pcs)
	
	enemies.on_enemies_dead.connect(_on_enemies_dead)
	pcs.on_characters_dead.connect(_on_player_characters_dead)
	
	$InputController/BattleBoard.set_pcs(pcs)
	$InputController/BattleBoard.set_enemies(enemies)
	$InputController/BattleBoard.start.visible = true
	
	chrono_controller.set_enemies(enemies)

func _on_start_pressed():
	$InputController/BattleBoard.start.visible = false
	chrono_controller.start()

func _on_enemies_dead():
	end = true
	print("VICTORY")
	$VictoryOverlay.visible = true
	on_victory.emit()

func _on_player_characters_dead():
	end = true
	print("DEFEAT")
	$DefeatOverlay.visible = true
	on_defeat.emit()
