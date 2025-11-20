extends MarginContainer

@export var character_a: Character
@export var character_b: Character
@export var character_c: Character
@export var character_d: Character
@export var character_e: Character

func _on_add_character_a_pressed():
	$"CenterContainer/Character Row".set_character($VBoxContainer/HBoxContainer2/Index.get_selected(), character_a)

func _on_add_character_b_pressed():
	$"CenterContainer/Character Row".set_character($VBoxContainer/HBoxContainer2/Index.get_selected(), character_b)

func _on_add_character_c_pressed():
	$"CenterContainer/Character Row".set_character($VBoxContainer/HBoxContainer2/Index.get_selected(), character_c)

func _on_add_character_d_pressed():
	$"CenterContainer/Character Row".set_character($VBoxContainer/HBoxContainer2/Index.get_selected(), character_d)

func _on_add_character_e_pressed():
	$"CenterContainer/Character Row".set_character($VBoxContainer/HBoxContainer2/Index.get_selected(), character_e)

func _on_character_row_on_character_ui_pressed(character):
	$Output.add_text("character_ui(%s) pressed\n" % character.name)
