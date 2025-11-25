class_name Game

extends Control

func _on_end_turn():
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
	
	$InputController/BattleBoard.set_pcs(pcs)
	$InputController/BattleBoard.set_enemies(enemies)
	$InputController/BattleBoard.roll_initiative()
	$InputController/BattleBoard/VBoxContainer/PanelContainer/Start.visible = true

func _on_start_pressed():
	$InputController/BattleBoard/VBoxContainer/PanelContainer/Start.visible = false
	start_turn($InputController/BattleBoard/VBoxContainer/Top/TurnOrder.cur_turn())
