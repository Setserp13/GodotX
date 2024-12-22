class_name xCamera

extends Node

static func fov_to_height(camera: Camera3D, distance: float) -> float:
	var fov_radians = deg_to_rad(camera.fov)
	return 2.0 * distance * tan(fov_radians / 2.0)

static func height_to_fov(height: float, distance: float) -> float:
	if distance == 0:
		push_error("Distance must be greater than zero")
		return 0
	var fov_radians = 2.0 * atan(height / (2.0 * distance))
	return rad_to_deg(fov_radians)
