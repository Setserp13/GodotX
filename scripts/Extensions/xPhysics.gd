class_name xPhysics

static func ignore_collision(body1, body2, value=true):
	body1.set_collision_mask_bit(body2.get_collision_layer(), value)
	body2.set_collision_mask_bit(body1.get_collision_layer(), value)

static func ignore_collision_with_group(body, group, value=true):
	for x in body.get_tree().get_nodes_in_group(group):
		ignore_collision(body, x, value)
