extends MarginContainer

@export var encounter: Encounter
@export var pcs: Array[BaseCharacter]

var _index: int

var _pcs: Array[Character]

func _ready():
	$Game/BattleBoard.set_encounter(encounter)
	$Game/BattleBoard.set_pcs(pcs)
	_pcs = $Game/BattleBoard._pcs
	for index in _pcs.size():
		var cur_pc = _pcs[index]
		if cur_pc != null:
			$"VBoxContainer/VBoxContainer/Player Turn/Character".add_item(cur_pc.name)
		else:
			$"VBoxContainer/VBoxContainer/Player Turn/Character".add_item("N/A")

func _on_set_state_pressed():
	match _index:
		0:
			var selected = $"VBoxContainer/VBoxContainer/Player Turn/Character".selected
			if selected > -1:
				var character = _pcs[selected]
				if character == null:
					push_error("index %s is invalid" % selected)
				else:
					print("character %s is not null" % character.name)
				$Game.to_player_turn(character)

func _on_state_item_selected(index):
	_reset()
	_index = index
	match index:
		0:
			$"VBoxContainer/VBoxContainer/Player Turn".visible = true

func _reset():
	$"VBoxContainer/VBoxContainer/Player Turn".visible = false

func _on_expand_pressed():
	$VBoxContainer.visible = !$VBoxContainer.visible
