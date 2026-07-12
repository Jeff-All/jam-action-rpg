class_name AdjustableResource

extends Node

signal on_cur_changed(AdjustableResource)
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
			if resource == CharacterCampaign.Resources.HEALTH:
				print("set health to %s from %s capped at %s" %[value, _cur, _max.adjusted])
			_cur = min(value, _max.adjusted)
			on_cur_changed.emit(self)

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
