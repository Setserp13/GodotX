extends BasicMove
class_name MoveAlong

@export var path: Path3D

func get_length():
	return path.curve.get_baked_length() if path else 0.0

func apply(t):
	if not path:
		return
	position = path.curve.sample_baked(t * get_length())