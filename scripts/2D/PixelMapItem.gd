@tool
extends Node

class_name PixelMapItem

enum CollisionMode {NONE, AREA, BODY}
enum RenderMode {CELLS, COLUMNS, COLUMNS_BETTER, ROWS, ROWS_BETTER}

@export var color = Color.BLACK
@export var collision_mode = CollisionMode.BODY
@export var render_mode = RenderMode.ROWS_BETTER
@export var ignore = false

static func get_rects(render_mode, image, predicate):
	var result = [
		xImage.get_cells,
		xImage.get_columns, xImage.get_columns_better,
		xImage.get_rows, xImage.get_rows_better
	][render_mode].call(image, predicate)
	for i in range(result.size()):
		result[i].position[1] = image.get_size()[1] - result[i].position[1] #'cuz godot is top to bottom
	return result

func generate(texture_map):
	pass
