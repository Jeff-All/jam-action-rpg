extends MarginContainer

@export var encounter: Encounter
@export var pcs: BasePlayerCharacters

func _ready():
	$Game/InputController.enemy_turn_input_state.timer = $Timer

func _on_setup_pressed():
	$Game.set_up(pcs.build_player_characters(), encounter)
