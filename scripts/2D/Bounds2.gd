@tool
extends Node2D

class_name Bounds2

@export var rect = Rect2(0, 0, 100, 100):
	get: return rect
	set(value):
		rect = value
		queue_redraw()

func _draw(): draw_rect(Rect2(rect.position - global_position, rect.size), Color(1, 0, 0, 0.5), false)

func _notification(what):
	if what == NOTIFICATION_DRAW:
		_draw()
