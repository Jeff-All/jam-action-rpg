extends MarginContainer

func reset():
	$GridSelector.fill([])
	$GridSelector.visible = true

func test1():
	$GridSelector.fill([
		preload("res://resources/weapons/weapon_rusty_longsword.tres"),
		preload("res://resources/actions/attacks/attack_mighty_blow.tres"),
	])

func test2():
	pass

func test3():
	pass

func test4():
	pass

func _on_selected(value):
	print("test._on_selected()")
	print("selected: %s" % value)
