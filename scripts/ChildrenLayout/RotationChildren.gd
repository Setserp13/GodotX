extends ChildrenLayout

class_name ChildrenRotation

@export var angular_speed = 180
var _cell_size

func update_child(delta, x, i):
	var angle = _cell_size * i
	var target = angle - PI / 2
	if Engine.is_editor_hint():
		x.rotation = target
	else:
		x.rotation = rotate_toward(x.rotation, target, deg_to_rad(angular_speed))
	return x.rotation == target
