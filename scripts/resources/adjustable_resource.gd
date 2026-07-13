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
			var change = min(value, _max.adjusted) - _cur
			_cur = min(value, _max.adjusted)
			on_cur_changed.emit(self, change)

var cur_floor: int:
	get:
		return floor(_cur)

func _init(_resource: CharacterCampaign.Resources, max_: float):
	resource = _resource
	_max.base = max_
	cur = max_
	
	_max.on_change.connect(_on_max_changed)

func _on_max_changed(_attribute: AdjustableAttribute):
	on_max_changed.emit(self)

func recover(multiplier: float):
	cur += (_recovery.adjusted * multiplier)
