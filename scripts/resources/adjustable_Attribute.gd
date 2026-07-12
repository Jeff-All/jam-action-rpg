class_name AdjustableAttribute

extends Resource

signal on_change(AdjustableAttribute)

var attribute: CharacterCampaign.Attributes
var base: float
var adjustments: Dictionary[Variant, float]
var override: int = -1

var adjusted: int:
	get:
		if attribute == CharacterCampaign.Attributes.ARMOR: print("get_adjustable_attribute")
		var value = base
		for cur in adjustments:
			value += adjustments[cur]
		if override < 0:
			return floor(value)
		else: return override

func _init(_attribute: CharacterCampaign.Attributes = CharacterCampaign.Attributes.STRENGTH):
	attribute = _attribute

func add_adjustment(key: Variant,value: float):
	print("Add Adjustment: %s -> %s" % [key, value])
	adjustments[key] = value
	on_change.emit(self)

func remove_adjustment(key: Variant):
	var erased = adjustments.erase(key)
	print("Remove Adjustment: %s -> %s" % [key, erased])
	on_change.emit(self)
