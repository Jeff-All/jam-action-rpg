extends HBoxContainer

var buttons: Array[BuffButton]
var buffs: Array[BuffActive]

func _ready():
	print("buff_bar.ready")
	var count = 0
	for cur_button in get_children():
		print("buff_bar.ready(): %s" % count)
		buttons.append(cur_button as BuffButton)
		count += 1
	build_Row()

func add_buff(active: BuffActive):
	print("buff_bar.add_buff")
	buffs.append(active)
	
	active.base.base.on_end.connect(on_buff_end)
	
	build_Row()

func remove_buff(active: BuffActive):
	print("buff_bar.remove_buff")
	buffs.remove_at(buffs.find(active))
	
	active.base.base.on_end.disconnect(on_buff_end)
	
	build_Row()

func build_Row():
	print("buff_bar.build_row(): %s" % buttons.size())
	var index = 0
	for cur_active in buffs:
		buttons[index].set_buff(cur_active)
		buttons[index].visible = true
		index += 1
		if index >= buttons.size():
			return
	while index < buttons.size():
		buttons[index].visible = false
		index += 1

func on_buff_end(active: BuffActive):
	remove_buff(active)
