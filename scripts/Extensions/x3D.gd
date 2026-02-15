class_name x3D

"""static func get_global_aabb(mesh_instance):
	var aabb = mesh_instance.mesh.get_aabb()
	var position = mesh_instance.to_global(aabb.position)
	var end = mesh_instance.to_global(aabb.end)
	return AABB(position, end - position)"""

static func get_global_aabb(mesh_instance: MeshInstance3D) -> AABB:
	var local_aabb = mesh_instance.mesh.get_aabb()
	var xf = mesh_instance.global_transform
	
	var min_v = Vector3(INF, INF, INF)
	var max_v = Vector3(-INF, -INF, -INF)
	
	for i in range(8):
		var corner = local_aabb.get_endpoint(i)
		var world_corner = xf * corner
		
		min_v.x = min(min_v.x, world_corner.x)
		min_v.y = min(min_v.y, world_corner.y)
		min_v.z = min(min_v.z, world_corner.z)
		
		max_v.x = max(max_v.x, world_corner.x)
		max_v.y = max(max_v.y, world_corner.y)
		max_v.z = max(max_v.z, world_corner.z)
	
	return AABB(min_v, max_v - min_v)

static func set_global_position(node3, value, pivot=Vector3.ZERO):
	node3.global_position += value - xRect2.denormalize_point(aabb(node3), pivot)

static func set_global_position_component(node3, value, pivot=0.0, axis=0):
	node3.global_position[axis] += value - xRect2.denormalize_point_component(aabb(node3), pivot, axis)

static func aabb(node3):
	return xNode.get_components(node3, MeshInstance3D).map(func(x):
		return get_global_aabb(x)).reduce(xAABB.aabb)

static func quad_box(parent, material):
	var positions = [Vector3.LEFT, Vector3.RIGHT, Vector3.DOWN, Vector3.UP, Vector3.BACK, Vector3.FORWARD]
	var rotations_degrees = [Vector3(0,-90,0), Vector3(0,90,0), Vector3(90,0,0), Vector3(-90,0,0),
	Vector3(0,0,0), Vector3(0,180,0)]
	for i in range(6):
		var quad = xNode.create_child(parent, MeshInstance3D, {'mesh': QuadMesh.new()})
		quad.material_override = material.duplicate()
		quad.position = positions[i] * 0.5
		quad.rotation_degrees = rotations_degrees[i]
	return parent
