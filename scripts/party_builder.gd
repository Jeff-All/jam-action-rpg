extends PanelContainer

var builders: Array[CharacterBuilder]

func _ready():
	for cur in $HBoxContainer.get_children():
		builders.append(cur)
		cur.visible = false

func hide_builders():
	for cur in builders:
		cur.visible = false

func show_builders(count: int):
	hide_builders()
	var index = 0
	var end = min(count, builders.size())
	while index < end:
		builders[index].activate()
		index += 1
