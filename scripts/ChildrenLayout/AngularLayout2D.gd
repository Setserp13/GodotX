extends CircularLayout2D

class_name AngularLayout2D

@export var min = 7 * PI / 12 #from 0 to 2PI
@export var size = -PI / 6 #from -2PI to 2PI
@export var translation_after_highlighted = -0.05 #from -2PI to 2PI
@export var angular_speed = 180
#@export var z_delta = -0.01

func update_child(delta, x, i):
	var angle = _cell_size * i
	var target = xMath.polar_to_cartesian(radius, angle) + center
	var target_rotation = angle - PI / 2
	if Engine.is_editor_hint():
		x.position = target
		x.rotation = target_rotation
	else:
		x.position = move_toward(x.position, target, speed)
		x.rotation = rotate_toward(x.rotation, target_rotation, deg_to_rad(angular_speed))
	return x.position == target and x.rotation == target_rotation
