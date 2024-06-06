class_name x3D

static func get_global_aabb(mesh_instance):
	var aabb = mesh_instance.mesh.get_aabb()
	var position = mesh_instance.to_global(aabb.position)
	var end = mesh_instance.to_global(aabb.end)
	return AABB(position, end - position)

static func set_global_position(node3, value, pivot=Vector3.ZERO):
	node3.global_position += value - xRect2.denormalize_point(aabb(node3), pivot)

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
