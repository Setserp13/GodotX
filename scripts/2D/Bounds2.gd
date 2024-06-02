@tool
extends Node2D

class_name Bounds2

@export var rect = Rect2(0, 0, 100, 100):
	get: return rect
	set(value):
		rect = value
		queue_redraw()

func _draw():
	var parent = get_parent()
	if parent == null:
		draw_rect(rect, Color(1, 0, 0, 0.5), false)
	else:
		draw_rect(Rect2(rect.position - parent.position, rect.size), Color(1, 0, 0, 0.5), false)

func _notification(what):
	if what == NOTIFICATION_DRAW:
		_draw()
