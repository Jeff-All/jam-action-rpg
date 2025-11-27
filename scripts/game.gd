class_name Game

extends Control

var end: bool = false

signal on_victory()
signal on_defeat()

func _on_end_turn():
	if end:
		return
	var next = $InputController/BattleBoard/VBoxContainer/Top/TurnOrder.next_turn()
	if next == null:
		print("NULL!")
	start_turn(next)

func start_turn(character: Character):
	print("%s.%s" % [character.name, character.count])
	if $InputController/BattleBoard/VBoxContainer/Bottom/PCs.character_map.has(character): 
		$InputController.to_player_turn(character)
	else:
		$InputController.to_enemy_turn(character)

func set_up(pcs: PlayerCharacters, encounter: Encounter):
	var enemies = encounter.build_enemies()
	
	enemies.bind_enemies()
	pcs.bind_player_characters()
	
	enemies.on_enemies_dead.connect(_on_enemies_dead)
	pcs.on_characters_dead.connect(_on_player_characters_dead)
	
	$InputController/BattleBoard.set_pcs(pcs)
	$InputController/BattleBoard.set_enemies(enemies)
	$InputController/BattleBoard.roll_initiative()
	$InputController/BattleBoard/VBoxContainer/PanelContainer/Start.visible = true

func _on_start_pressed():
	$InputController/BattleBoard/VBoxContainer/PanelContainer/Start.visible = false
	start_turn($InputController/BattleBoard/VBoxContainer/Top/TurnOrder.cur_turn())

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
