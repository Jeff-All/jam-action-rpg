class_name CampaignTier

extends Resource

@export var battles: Array[BattleOptions]
@warning_ignore("unused_private_class_variable")
var _battles: Array[BattleOptions]
var _prev_battle: BattleOptions
var _next_battle: BattleOptions
@export var battles_to_next: int = 1

@export var weapons: Array[Weapon]
@export var armor: Array[Armor]
@export var traits: Array[Trait]
@export var abilities: Array[Ability]
@export var consumables: Array
