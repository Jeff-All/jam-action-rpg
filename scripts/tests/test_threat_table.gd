extends MarginContainer

@export var player_characters: BasePlayerCharacters

var table: ThreatTable



func _on_build_pressed() -> void:
	var pcs = player_characters.build_player_characters()
	table = ThreatTable.new()
	table.set_table(pcs)
	
	$CenterContainer/ThreatTable.bind_table(table)
