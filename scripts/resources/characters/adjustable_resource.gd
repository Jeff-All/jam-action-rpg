class_name AdjustableResource

extends Node

signal on_cur_changed(resource: AdjustableResource, change: float)
signal on_max_changed(AdjustableResource)

var resource: CharacterCampaign.Resources
var _max: AdjustableAttribute = AdjustableAttribute.new()
var _recovery: AdjustableAttribute = AdjustableAttribute.new()
var _cur: float

var cur: float:
	get:
		return _cur
	set(value):
		if value != _cur:
			if resource == CharacterCampaign.Resources.SHIELDING: print("set_cur: shielding: %s" % [_max.base])
			if _max.base >= 0:
				value = min(value, _max.adjusted)
			var change = value - _cur
			_cur = value
			on_cur_changed.emit(self, change)

var cur_floor: int:
	get:
		return floor(_cur)

var percentage: float:
	get:
		return _cur / _max.adjusted as float

var maxed: bool:
	get: return _cur >= _max.adjusted

func _init(_resource: CharacterCampaign.Resources, max_: float):
	if _resource == CharacterCampaign.Resources.SHIELDING: print("_init: shielding: %s" % [max_])
	resource = _resource
	_max.base = max_
	cur = max_
	
	_max.on_change.connect(_on_max_changed)

func _on_max_changed(_attribute: AdjustableAttribute):
	on_max_changed.emit(self)

func recover(multiplier: float):
	cur += (_recovery.adjusted * multiplier)
