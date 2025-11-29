class_name ThreatTable

extends Node

signal on_sort()

class ThreatTuple:
	var character: Character
	var threat: int

var table: Array[ThreatTuple]
var character_map: Dictionary[PlayerCharacter, ThreatTuple]

var sort_function: Callable = _default_sort
var base_threat_function: Callable = _default_base_threat

func _default_sort(a,b) -> bool:
	return a.threat > b.threat

func _default_base_threat(pc: PlayerCharacter) -> int:
	print("%s threat %s" % [pc.name, pc.max_health + pc.armor + pc.max_durability + pc.strength])
	return pc.max_health + pc.armor + pc.max_durability + pc.strength

func set_table(player_characters: PlayerCharacters):
	for cur_pc in player_characters.characters:
		var tuple = ThreatTuple.new()
		tuple.character = cur_pc
		tuple.threat = base_threat_function.call(cur_pc)
		character_map[cur_pc] = tuple
		table.append(tuple)
	sort_table()

func adjust_threat(pc: PlayerCharacter, threat: int):
	var tuple = character_map[pc]
	tuple.threat += threat
	
	sort_table()
	
	var table_string = ""
	for cur in table:
		table_string = "%s,%s.%s" % [table_string, cur.character.name, cur.threat]
	print("adjust threat %s by %s [%s]" % [pc.name, threat, table_string])

func set_threat(pc: PlayerCharacter, threat: int):
	var tuple = character_map[pc]
	tuple.threat = threat
	
	sort_table()

func sort_table():
	table.sort_custom(sort_function)
	
	on_sort.emit()
