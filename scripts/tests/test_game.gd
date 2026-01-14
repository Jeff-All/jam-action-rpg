extends MarginContainer

@export var encounter: Encounter
@export var pcs: BasePlayerCharacters

func _on_setup_pressed():
	$Game.set_up(pcs.build_player_characters(), encounter)
