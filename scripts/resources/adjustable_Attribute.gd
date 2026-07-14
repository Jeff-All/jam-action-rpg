class_name AdjustableAttribute

extends Resource

signal on_change(AdjustableAttribute)

var attribute: CharacterCampaign.Attributes
var base: float
var adjustments: Dictionary[Variant, float]

var override: int:
	set(value):
		if value != _override:
			_override = value
			on_change.emit(self)

var _override: int = -1

var adjusted: int:
	get:
		var value = base
		for cur in adjustments:
			value += adjustments[cur]
		if _override < 0:
			return floor(value)
		else: return _override

func _init(_attribute: CharacterCampaign.Attributes = CharacterCampaign.Attributes.STRENGTH):
	attribute = _attribute

func reset():
	adjustments.clear()

func add_adjustment(key: Variant,value: float):
	adjustments[key] = value
	on_change.emit(self)

func remove_adjustment(key: Variant):
	adjustments.erase(key)
	on_change.emit(self)
