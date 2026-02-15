class_name x2D

static func get_region_size(sprite):
	if sprite.region_enabled:
		return sprite.region_rect.size
	return sprite.texture.get_size()

static func get_global_size(sprite): return get_region_size(sprite) * sprite.global_scale
	
static func get_global_extents(sprite): return get_global_size(sprite) * 0.5

static func get_global_rect(sprite):
	return xRect2.transform_rect(sprite.get_rect(), sprite.global_transform)
	#return Rect2(sprite.global_position - get_global_extents(sprite), get_global_size(sprite))
	
static func get_size(sprite): return get_region_size(sprite) * sprite.scale

static func get_extents(sprite): return get_size(sprite) * 0.5

static func get_rect(sprite):
	return Rect2(sprite.position - get_extents(sprite), get_size(sprite))

static func global_scale_relative(transform, value, pivot):
	var delta = transform.global_position - pivot
	var old_scale = transform.global_scale
	transform.global_scale = value
	transform.global_position = pivot + (delta * value) / old_scale

static func scale_relative(transform, value, pivot):
	var delta = transform.position - pivot
	var old_scale = transform.scale
	transform.scale = value
	transform.position = pivot + (delta * value) / old_scale

static func set_size(sprite, value : Vector2):	sprite.scale = value / get_region_size(sprite)

static func set_global_size(sprite, value : Vector2):
	sprite.global_scale = value / get_region_size(sprite)

static func set_size_component(sprite, index, value : float, preserve_aspect=true):
	if preserve_aspect:
		sprite.scale = (value / get_region_size(sprite)[index]) * Vector2(1, 1)
	else:
		sprite.scale[index] = value / get_region_size(sprite)[index]
		#print(sprite.scale)

static func set_global_size_component(sprite, index, value : float, preserve_aspect=true):
	if preserve_aspect:
		sprite.global_scale = (value / get_region_size(sprite)[index]) * Vector2(1, 1)
	else:
		sprite.global_scale[index] = value / get_region_size(sprite)[index]
		#print(sprite.scale)

static func denormalize_point(sprite, value):
	return xRect2.denormalize_point(get_rect(sprite), value)

static func normalize_point(sprite, value):
	return xRect2.normalize_point(get_rect(sprite), value)

static func normalized_to_global_point(sprite, value):
	return xRect2.denormalize_point(get_global_rect(sprite), value)

static func global_to_normalized_point(sprite, value):
	return xRect2.normalize_point(get_global_rect(sprite), value)
	
static func set_global_position(sprite, value, normalized_pivot):
	sprite.position += value - normalized_to_global_point(sprite, normalized_pivot)

static func OOBB_normalized_to_global_point(sprite, point):
	var angle = sprite.global_rotation_degrees
	sprite.global_rotation_degrees = 0
	var axis_aligned_point = normalized_to_global_point(sprite, point)
	var result = sprite.global_position + xVector2.rotate(axis_aligned_point - sprite.global_position, deg_to_rad(angle))
	sprite.global_rotation_degrees = angle
	return result

static func set_OOBB_global_position(sprite, value, normalized_pivot=Vector2.ONE * 0.5):
	sprite.global_position += (value - OOBB_normalized_to_global_point(sprite, normalized_pivot))

static func set_OOBB_global(sprite, position, size, normalized_pivot=Vector2.ZERO):
	var angle = sprite.global_rotation
	sprite.rotation_degrees = 0
	set_global_size(sprite, size)
	sprite.rotation_degrees = angle
	set_OOBB_global_position(sprite, position, normalized_pivot)

static func fit_collider_to_sprite(collider, sprite, l=0.0, r=0.0, d=0.0, u=0.0, relative=true):
	if collider == null:
		print("No CollisionShape2D component found on the sprite.")
		return
	var rect = xRect2.padding(get_rect(sprite), l, r, d, u, relative)
	var extents = rect.size * 0.5
	if collider.get_parent() == sprite:
		collider.position = Vector2.ZERO
	else:
		collider.position = sprite.position
	match collider.shape.get_class():
		"CapsuleShape2D":
			if extents.y > extents.x:
				collider.shape.height = extents.y * 2.0
				collider.shape.radius = extents.x
			else:
				collider.rotation_degrees = 90.0
				collider.shape.height = extents.x * 2.0
				collider.shape.radius = extents.y
		"CircleShape2D":
			collider.shape.radius = min(extents.x, extents.y)
		"RectangleShape2D":
			collider.shape.extents = extents
		_:
			print("Collision shape is not a valid shape.")

static func fit_collider(body, l=0.0, r=0.0, d=0.0, u=0.0, relative=true):
	var sprite = xNode.get_component(body, Sprite2D)
	var collider = xNode.get_component(body, CollisionShape2D)
	fit_collider_to_sprite(collider, sprite, l, r, d, u)

static func add_collider(body, collision_shape, l=0.0, r=0.0, d=0.0, u=0.0, relative=true):
	xNode.create_child(body, CollisionShape2D, {'shape': collision_shape.new()})
	fit_collider(body, l, r, d, u)


static func get_collisions(body):
	return xArray.fromfun(body.get_slide_collision_count(), func(i): return body.get_slide_collision(i))

static func get_intersecting_areas(collider: CollisionShape2D) -> Array:
	var result = []
	var space_state = collider.get_world_2d().direct_space_state
	var shape_owner = collider.get_shape()
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = shape_owner
	query.transform = collider.global_transform
	query.collide_with_areas = true
	var query_results = space_state.intersect_shape(query)
	for item in query_results:
		if item.collider is Area2D and item.collider != collider.get_parent():
			result.append(item.collider)
	return result

static func aabb(node2):
	return xNode.get_components(node2, Sprite2D).map(func(x): return x2D.get_global_rect(x)).reduce(xRect2.aabb)

static func position_bounds(rect, object_size, pivot=Vector2.ONE * 0.5):
	var l = object_size.x * pivot.x
	var r = object_size.x - l
	var d = object_size.y * pivot.y
	var u = object_size.y - d
	return xRect2.absolute_padding(rect, l, r, d, u)
