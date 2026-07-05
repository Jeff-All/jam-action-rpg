class_name ThreatTable

extends Resource

var table: Dictionary[PCUI, int]
var last_target: PCUI = null

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

func add_threat(target: PCUI, value: int):
	print("threat_table.add_threat() %s -> %s" % [target.name, value])
	var cur_threat = 0
	if table.has(target):
		cur_threat = table[target]
	cur_threat += value
	if cur_threat > Global.max_threat:
		last_target = target
		var excess_threat = cur_threat - Global.max_threat
		for cur in table:
			if cur != target:
				table[cur] = min(table[cur] , max(table[cur] - excess_threat, 0))
	else:
		table[target] = cur_threat
