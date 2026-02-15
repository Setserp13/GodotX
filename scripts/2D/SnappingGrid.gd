@tool
extends Node2D

class_name SnappingGrid

@export var offset = Vector2.ZERO
@export var cell_size = Vector2.ONE * 100
@export var enabled = true
@export var grid_color: Color = Color(1, 1, 1, 0.2) # light grid
@export var border_color: Color = Color(1, 0, 0, 0.5) # optional border
@export var child_bounds_color: Color = Color(1, 0, 0, 0.5)

func snap_point(point):
	return (point / cell_size).floor() * cell_size + offset + position

func _process(delta):
	if not Engine.is_editor_hint():
		return
	set_meta("_edit_lock_", true)
	queue_redraw()
	#_draw()
	if not enabled:
		return
	for x in get_children():
		var rect = x2D.aabb(x)
		var pos = xRect2.denormalize_point(rect, Vector2(0.5, 1.0))
		x.position += snap_point(pos) - pos
		#x.position = (x.position / cell_size).floor() * cell_size

	
	
func get_editor_camera_rect() -> Rect2:
	var viewport = get_viewport()
	var rect = viewport.get_visible_rect()
	var xform = viewport.get_final_transform()
	var zoom = xform.x.x	#xform.get_scale().x
	var pos = -xform.get_origin() / zoom
	var size = rect.size / zoom

	return Rect2(pos, size)

func _draw():

	var viewport = get_editor_camera_rect()
	#print(viewport)

	for axis in range(2):
		for x in range(viewport.position[axis], viewport.end[axis], cell_size[axis]):
			var start = viewport.position
			var end = viewport.end
			start[axis] = x
			end[axis] = x
			start = snap_point(start)
			end = snap_point(end)
			draw_line(start, end, grid_color)

	# Optional border (visual reference)
	draw_rect(Rect2(viewport.position, viewport.size), border_color, false)
	
	for x in get_children():
		draw_rect(x2D.aabb(x), child_bounds_color, false)

func _notification(what):
	if what == NOTIFICATION_DRAW:
		_draw()
