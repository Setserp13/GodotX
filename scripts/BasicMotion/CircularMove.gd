extends BasicMove
class_name CircularMove

@export var center := Vector3.ZERO
@export var radius := 1.0
@export var axis := Vector3.UP

func get_length():
	return TAU * radius

func apply(t):
	var angle := TAU * t
	var v := Vector3(radius, 0, 0).rotated(axis, angle)
	global_position = center + v