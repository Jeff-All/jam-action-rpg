class_name AllocationBuilder

extends Resource

var min_party = 1
var max_party = 4
var min_cr = 0
var max_cr = 3

var starters = {
	1:{1:3,2:4,3:4,4:4},
	2:{1:4,2:6,3:7,4:8,5:8,6:8,7:8},
	3:{2:7,3:9,4:10,5:11,6:12,7:12},
	4:{1:5,2:8,3:10,4:12,5:13,6:14,7:15},
	5:{2:9,3:11,4:13,5:15,6:16,7:17},
	6:{2:9,3:12,4:14,5:16,6:18,7:19},
	7:{3:13,4:15,5:17,6:19,7:21},
}

var indexes: Array[int] = [6,4,3,2,1]

func build_allocations():
	var allocations = {}
	for party in range(min_party, max_party + 1):
		allocations[party] = {}
		for cr in range(min_cr, max_cr + 1):
			var returned = build_allocations_for_party_cr(party, cr)
			if returned == null: continue
			allocations[party][cr] = returned
	
	return _convert(allocations)

func build_allocations_for_party_cr(party: int, cr: int):
	var final_cr = party + cr
	var allocations = {}
	for enemies in starters[final_cr]:
		var actions = party - enemies
		var val = starters[final_cr][enemies] + actions
		if party == 1 && cr == 0 && enemies == 3: print("val: %s" % val)
		var returned = build_allocation_entry(val, enemies, indexes, 100, party == 1 && cr == 0 && enemies == 3)
		if returned == null: continue
		allocations[enemies] = returned
	if allocations.size() == 0: 
		return null
	return allocations

func build_allocation_entry(val: int, enemies: int, _indexes: Array[int], breaker: int = 100, verbose = false):
	if breaker <= 0: 
		printerr("BREAK!!!!")
		return
	var index = _indexes[0]
	if enemies * index < val: return null
	if _indexes.size() <= 1:
		if val % index != 0: return null
		if verbose:
			print("check: %s / %s = %s" % [val, index, (val as float / index) as int])
		var num = (val as float / index) as int
		if num < enemies: return null
		return num
	var allocations = {}
	for cur in range(0, floor(val as float / index) as int + 1):
		if val - (cur * index) == 0:
			if cur == enemies:
				allocations[cur] = "x"
			continue
		var returned = build_allocation_entry(val - (cur * index), enemies - cur, _indexes.slice(1, _indexes.size()), breaker - 1)
		if returned == null: continue
		allocations[cur] = returned
	if allocations.size() == 0: 
		return null
	return allocations

func _convert(allocations):
	var converted = {}
	for party in allocations:
		converted[party] = {}
		for cr in allocations[party]:
			converted[party][cr] = {}
			for enemies in allocations[party][cr]:
				var returned = convert_entry(allocations[party][cr][enemies], [])
				for cur in returned:
					for index in range(max(0,cur.size()), indexes.size()):
						cur.append(0)
				converted[party][cr][enemies] = returned
				#print("_convert -> %s" % [returned])
	return converted

func convert_entry(entry, _arr):
	#print("convert_entry: %s - %s" % [entry, _arr])
	var to_return = []
	for key in entry:
		var arr = _arr.duplicate()
		arr.append(key)
		var cur_entry = entry[key]
		if cur_entry is Dictionary:
			var returned = convert_entry(entry[key], arr)
			for cur_returned in returned:
				to_return.append(cur_returned)
		else: 
			if cur_entry is int:
				arr.append(cur_entry)
			to_return.append(arr)
	
	return to_return
