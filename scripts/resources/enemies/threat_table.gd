class_name ThreatTable

extends Resource

signal on_threat_change(target: PCUI)

var table: Dictionary[PCUI, float]
var last_target: PCUI = null

var max_threat: float = 0.0
var min_threat: float = 0.0
var threat_width: float:
	get:
		return max_threat - min_threat

func find_target() -> PCUI:
	var cur_target = null
	var cur_threat = 0.0
	for cur in table:
		if !cur.dead:
			if cur_target == null || table[cur] > cur_threat:
				cur_target = cur
				cur_threat = table[cur]
			else: if table[cur] == cur_threat:
				if last_target == cur_target || last_target == cur:
					return last_target
	last_target = cur_target
	return cur_target

func build_table(pcs: Array[PCUI]):
	for cur in pcs:
		if cur._character != null:
			var cur_threat = cur._character.attributes[CharacterCampaign.Attributes.THREAT].adjusted
			add_threat(cur, cur_threat)
			if cur._character.max_threat > max_threat: max_threat = cur._character.max_threat
			if cur._character.min_threat < min_threat: min_threat = cur._character.min_threat

func add_threat(target: PCUI, value: float):
	var cur_threat = 0
	if table.has(target):
		cur_threat = table[target]
	cur_threat += value
	if cur_threat > target._character.max_threat:
		@warning_ignore("narrowing_conversion")
		table[target] = target._character.max_threat
		var excess_threat = cur_threat - target._character.max_threat
		var _max_threat = target._character.max_threat
		var max_threat_target = target
		for cur in table:
			if cur != target:
				var other_threat = min(table[cur] , max(table[cur] - excess_threat, cur._character.min_threat))
				table[cur] = other_threat
				if other_threat > _max_threat:
					_max_threat = other_threat
					max_threat_target = cur
		last_target = max_threat_target
	else:
		table[target] = cur_threat
	on_threat_change.emit(target)
