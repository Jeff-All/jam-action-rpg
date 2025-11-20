extends MarginContainer

@export var character_a: BaseCharacter

func _on_character_a_pressed():
	$CenterContainer/TurnOrder.add_character($CharacterController.build_character(character_a))

func _on_next_turn_pressed():
	$CenterContainer/TurnOrder.next_turn()
