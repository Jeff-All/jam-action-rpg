extends MarginContainer

var button: AbilityButton

func _ready():
	button = $MarginContainer/AbilityButton

func _on_cooldown_pressed():
	print("on_cooldown_pressed")
	var cooldown = $HBoxContainer/Cooldown.value
	
	button._on_cooldown_started(cooldown)

func _on_afford_pressed():
	if $HBoxContainer/Afford.text == "can afford":
		button._on_cant_afford()
		$HBoxContainer/Afford.text = "can't afford"
	else :
		button._on_can_afford()
		$HBoxContainer/Afford.text = "can afford"
