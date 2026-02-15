extends BasicMove
class_name Scale

@export var scale_delta := Vector3.ONE
var _base: Vector3

func start():
	super()
	_base = scale

func get_length():
	return scale_delta.length()

func apply(t):
	scale = _base + scale_delta * t