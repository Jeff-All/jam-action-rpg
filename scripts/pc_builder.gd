extends MarginContainer

@export var races: Array[Race]
@export var classes: Array[Class]

var _race: Race
var _class: Class

func _ready():
	for cur_race in races:
		$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Race.add_item(cur_race.name)
	
	for cur_class in classes:
		$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/Class.add_item(cur_class.name)
	
	_race = races[0]
	_class = classes[0]
	
	_update_values()

func _on_race_item_selected(index: int) -> void:
	_race = races[index]
	_update_values()

func _on_class_item_selected(index: int) -> void:
	_class = classes[index]
	_update_values()

func _update_values():
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Strength.text = "%s" % (_race.strength + _class.strength)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Agility.text = "%s" % (_race.agility + _class.agility)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Magic.text = "%s" % (_race.magic + _class.magic)
	
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Attack.text = "%s" % _class.attack
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Defense.text = "%s" % _class.defense
	
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Armor.text = "%s" % ( _race.armor + _class.armor)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Durability.text = "%s" % (_race.durability + _class.durability)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Health.text = "%s" % (_race.health + _class.health)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Stamina.text = "%s" % (_race.stamina + _class.stamina)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Mana.text = "%s" % (_race.mana + _class.mana)
	
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer5/HealthRecovery.text = "%s" % (_race.health_recovery + _class.health_recovery)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer5/StaminaRecovery.text = "%s" % (_race.stamina_recovery + _class.stamina_recovery)
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer5/ManaRecovery.text = "%s" % (_race.mana_recovery + _class.mana_recovery)
