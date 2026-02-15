extends BasicMove
class_name Move

@export var offset := Vector3(1, 0, 0)
var _start: Vector3

func start():
	super()
	_start = position

func get_length():
	return offset.length()

func apply(t):
	position = _start + offset * t