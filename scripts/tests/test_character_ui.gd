extends MarginContainer

@export var character_a: Character
@export var character_b: Character

func _set_character_a():
	$CenterContainer/Character.character = character_a

func _set_character_b():
	$CenterContainer/Character.character = character_b

func _test_2():
	print($CenterContainer/Character.character.name)

func _test_change_attribute():
	var value = $VBoxContainer/HBoxContainer3/Value.value * ( -1 if $VBoxContainer/HBoxContainer3/Sign.selected == 1 else 1)
	match($VBoxContainer/HBoxContainer3/Attribute.selected):
		0: $CenterContainer/Character.character.cur_armor = int(value)
		1: $CenterContainer/Character.character.cur_health = int(value) 
		2: $CenterContainer/Character.character.cur_stamina = int(value) 
		3: $CenterContainer/Character.character.cur_mana = int(value) 

func _on_character_on_pressed(character):
	$Output.add_text("Character(%s) pressed\n" % character.name)

func _on_active_toggled(toggled_on):
	$CenterContainer/Character.active = toggled_on

func _on_available_toggled(toggled_on):
	$CenterContainer/Character.available = toggled_on
