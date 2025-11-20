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

func set_up(pcs: Array[BaseCharacter], encounter: Encounter):
	$InputController/BattleBoard.set_pcs(pcs)
	$InputController/BattleBoard.set_encounter(encounter)
	var first = $InputController/BattleBoard.roll_initiative()
	if first._character == null:
		print("NULL!")
	start_turn(first._character)
