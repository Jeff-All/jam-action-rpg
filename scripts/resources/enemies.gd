class_name Enemies

extends Resource

@export var front_row: Array[Enemy]
@export var back_row: Array[Enemy]

var all: Array[Enemy]:
	get():
		return front_row + back_row
