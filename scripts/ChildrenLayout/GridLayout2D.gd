@tool
extends PropertyLayout

class_name GridLayout2D

@export var constraint = 10
@export var start_axis = 0 #	Which primary axis to place elements along. Horizontal will fill an entire row before a new row is started. Vertical will fill an entire column before a new column is started.
@export var cell_size = Vector2.ONE * 100
@export var spacing = Vector2.ZERO
@export var offset = Vector2.ZERO
@export var pivot = Vector2.ONE * 0.5
var size = Vector2.ONE

func get_cell_index(i):
	var start_axis_index = i % constraint
	var other_axis_index = floor(i / constraint)
	var cell_index = Vector2.ONE
	cell_index[start_axis] = start_axis_index
	cell_index[1 - start_axis] = other_axis_index
	return cell_index

func get_child_index(cell_index: Vector2) -> int:
	var start_axis_index = cell_index[start_axis]
	var other_axis_index = cell_index[1 - start_axis]
	return int(start_axis_index + other_axis_index * constraint)

func get_cell(cell_index: Vector2):
	var index = get_child_index(cell_index)
	if index > -1 and index < children().size():
		return children()[index]
	return null

func _process(delta):
	var cell_index = get_cell_index(children().size() - 1)
	#print(cell_index)
	size = (cell_size + spacing) * cell_index
	super._process(delta)

func get_target(i):
	return offset + (cell_size + spacing) * get_cell_index(i) - size * pivot
