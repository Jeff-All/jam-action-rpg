class_name PostBattle

extends Control

signal on_end()
signal on_add_item(item: Resource)

var xp_gain: XPGain
var loot: LootUI

func _ready():
	xp_gain = $XPGain
	loot = $Loot

func start(party: Array[CharacterCampaign], _items: Array[Resource]):
	loot.visible = false
	loot.setup(_items)
	xp_gain.setup(party)
	xp_gain.visible = true

func _xp_gain_on_continue():
	xp_gain.visible = false
	
	loot.visible = true

func _loot_on_item_selected(item: Resource):
	on_add_item.emit(item)
	on_end.emit()
