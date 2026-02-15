extends BasicMove
class_name ArcMove

@export var center := Vector3.ZERO
@export var radius := 1.0
@export var axis := Vector3.UP
@export var arc_angle := PI

func get_length():
	return abs(arc_angle) * radius

func apply(t):
	var a := arc_angle * t
	var v := Vector3(radius, 0, 0).rotated(axis, a)
	global_position = center + v