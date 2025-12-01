extends MarginContainer

@export var character_a: BasePlayerCharacter

@export var cost_a: Dictionary[Character.CharacterResource, int]

func _on_cost_a_pressed():
	var character = character_a.build_player_character()
	
	$CenterContainer/CostBar.set_cost(character, cost_a)
