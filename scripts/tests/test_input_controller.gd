extends Node

@export var encounter_a: Encounter
@export var character_a: BaseCharacter
@export var button_set_a: Array[Action]

var expanded: bool = false

func _on_expand_pressed():
	$HBoxContainer.visible = expanded
	expanded = !expanded

func _on_encounter_a_pressed():
	$Game/BattleBoard.enemies.set_encounter(encounter_a)

func _on_character_a_pressed():
	$Game/BattleBoard.pcs.set_character(2,  Character.new(character_a))

func _on_buttons_a_pressed():
	$Game/BattleBoard.buttons.bind_actions(button_set_a)
