extends Node

@export var base_cooldown: float = 1.5

@export var action_button_map: Array = [
	["action_button_1_1", "action_button_1_2", "action_button_1_3", "action_button_1_4"],
	["action_button_2_1", "action_button_2_2", "action_button_2_3", "action_button_2_4"],
	["action_button_3_1", "action_button_3_2", "action_button_3_3", "action_button_3_4"],
	["action_button_4_1", "action_button_4_2", "action_button_4_3", "action_button_4_4"]
]

@export var action_button_art_map: Dictionary[String, Resource] = {
	"action_button_1_1": preload("res://resources/art/icons/keybinds/1.png"),
	"action_button_1_2": preload("res://resources/art/icons/keybinds/2.png"),
	"action_button_1_3": preload("res://resources/art/icons/keybinds/3.png"),
	"action_button_1_4": preload("res://resources/art/icons/keybinds/4.png"),
	
	"action_button_2_1": preload("res://resources/art/icons/keybinds/Q.png"),
	"action_button_2_2": preload("res://resources/art/icons/keybinds/W.png"),
	"action_button_2_3": preload("res://resources/art/icons/keybinds/E.png"),
	"action_button_2_4": preload("res://resources/art/icons/keybinds/R.png"),
	
	"action_button_3_1": preload("res://resources/art/icons/keybinds/A.png"),
	"action_button_3_2": preload("res://resources/art/icons/keybinds/S.png"),
	"action_button_3_3": preload("res://resources/art/icons/keybinds/D.png"),
	"action_button_3_4": preload("res://resources/art/icons/keybinds/F.png"),
	
	"action_button_4_1": preload("res://resources/art/icons/keybinds/Z.png"),
	"action_button_4_2": preload("res://resources/art/icons/keybinds/X.png"),
	"action_button_4_3": preload("res://resources/art/icons/keybinds/C.png"),
	"action_button_4_4": preload("res://resources/art/icons/keybinds/V.png")
}

@export var empty_slotButton: Resource = preload("res://resources/abilities/none.tres")

@export var combat_text: PackedScene = preload("res://scenes/ui/combat_text.tscn")
