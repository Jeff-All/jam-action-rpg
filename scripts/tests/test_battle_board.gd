extends Node

@export var encounter_a: Encounter
@export var pc_set_a: Array[BaseCharacter]
@export var action_set_a: Array[Action]

var expanded: bool = false

func _on_expand_pressed():
	$HBoxContainer.visible = expanded
	expanded = !expanded

func _on_encounter_a_pressed():
	$MarginContainer/BattleBoard.set_encounter(encounter_a)

func _on_characters_a_pressed():
	$MarginContainer/BattleBoard.set_pcs(pc_set_a)

func _on_buttons_a_pressed():
	$MarginContainer/BattleBoard.bind_actions(action_set_a)

func _on_action_pressed(action_button, index):
	print("_on_action_pressed(%s, %s)" % [action_button.action.name, index])

func _on_enemy_pressed(character, row, index):
	print("_on_enemy_pressed(%s, %s, %s)" % [character.name, row, index])

func _on_pc_pressed(character, index):
	print("_on_pc_pressed(%s, %s)" % [character.name, index])

func _on_roll_initiative_pressed():
	var first = $MarginContainer/BattleBoard.roll_initiative()
	first._character.active = true
