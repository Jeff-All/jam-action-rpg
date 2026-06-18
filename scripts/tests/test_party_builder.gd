extends Control

@export var start_options_1: CharacterStartOptions

func options1():
	$PartyBuilder.character_start_options = start_options_1

func test1():
	$PartyBuilder.show_builders(1)

func test2():
	$PartyBuilder.show_builders(2)

func test3():
	$PartyBuilder.show_builders(3)

func test4():
	$PartyBuilder.show_builders(4)

func test5():
	$PartyBuilder.show_builders(5)
