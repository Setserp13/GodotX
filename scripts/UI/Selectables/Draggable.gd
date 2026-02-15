extends Control

# Define variables
var start_screen_point
var offset
export var horizontal = true
export var vertical = true

# Define input event handlers
func _on_drag_start(event, data):
	start_screen_point = get_viewport().get_camera().unproject_position(global_transform.origin)
	offset = global_transform.origin - get_viewport().get_camera().unproject_position(Vector3(data.position.x, data.position.y, start_screen_point.z))

func _on_drag(event, data):
	var screen_point = Vector3(data.position.x, data.position.y, start_screen_point.z)
	var position = get_viewport().get_camera().unproject_position(screen_point) + offset
	if not horizontal:
		position.x = global_transform.origin.x
	if not vertical:
		position.y = global_transform.origin.y
	global_transform.origin = position
