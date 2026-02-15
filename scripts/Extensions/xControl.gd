class_name xControl

#do not work cuz Control has no global_scale, so the result is null
#static func get_global_size(control): return control.size * control.global_scale

static func aabb(control):
	return xNode.descendants_of_type(control, Control).map(func(x): return x.get_global_rect()).reduce(xRect2.aabb)

static func set_axis_global_position(node, axis, position, pivot=0.5):
	var delta = position - xRect2.denormalize_point(node.get_global_rect(), pivot)
	node.global_position[axis] += delta[axis]

static func set_global_position(node, position, pivot=Vector2.ONE * 0.5):
	var delta = position - xRect2.denormalize_point(node.get_global_rect(), pivot)
	node.global_position += delta
