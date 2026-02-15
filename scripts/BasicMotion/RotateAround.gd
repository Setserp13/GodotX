extends BasicMove
class_name RotateAround

@export var center := Vector3.ZERO
@export var axis := Vector3.UP
@export var angle := TAU

var _offset: Vector3
var _radius := 0.0

func start():
	super()
	_offset = global_position - center
	_radius = _offset.length()

func get_length():
	return abs(angle) * _radius

func apply(t):
	var rot := Basis(axis.normalized(), angle * t)
	global_position = center + rot * _offset