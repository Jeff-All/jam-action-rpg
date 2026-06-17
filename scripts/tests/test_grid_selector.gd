extends MarginContainer

func reset():
	$GridSelector.fill([])
	$GridSelector.visible = true

func test1():
	$GridSelector.fill([
		[preload("res://resources/weapons/weapon_long_sword.tres"),  preload("res://resources/art/icons/1.png")],
		[preload("res://resources/actions/attacks/attack_mighty_blow.tres"),  preload("res://resources/art/icons/2.png")],
	])

func test2():
	$GridSelector.fill([
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
	])

func test3():
	$GridSelector.fill([
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
	])

func test4():
	$GridSelector.fill([
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
		["2",  preload("res://resources/art/icons/2.png")],
		["3",  preload("res://resources/art/icons/3.png")],
		["4",  preload("res://resources/art/icons/4.png")],
		
		["1",  preload("res://resources/art/icons/1.png")],
	])

func _on_selected(value):
	print("test._on_selected()")
	print("selected: %s" % value)
