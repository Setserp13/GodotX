@tool
extends Node

class_name SnappingAABB3D

var _axes = {'X': true, 'Y': true, 'Z': true, 'XY': false, 'XZ': false, 'YZ': false, 'XYZ': false}

func _get(property):
	if property in _axes:
		return _axes[property]
		
func _set(property, value):
	if property in _axes:
		_axes[property] = value
		update_others(property)
		return true
	return false

#SET OPERATIONS WITH STRINGS
static func contains(a, b):
	for i in range(b.length()):
		if b[i] not in a:
			return false
	return true

func update_others(k):
	if _axes[k]:
		for l in _axes:
			if k != l and (contains(str(k), l) or contains(l, str(k))):
				_axes[l] = false

func _get_property_list():
	return _axes.keys().map(
		func(x):
			return {'name': x, 'type': TYPE_BOOL}
	)

@export var snap_distance = 10

@export var from_corner = true
@export var from_mid_edge = true
@export var from_face_centers = true
@export var from_center = true

@export var to_corner = true
@export var to_mid_edge = true
@export var to_face_centers = true
@export var to_center = true

@export var enabled = true

func get_points(aabb, corner, mid_edge, face_centers, center):
	var result = []
	if corner:
		result += xAABB.corners(aabb)
	if mid_edge:
		result += xAABB.mid_edges(aabb)
	if face_centers:
		result += xAABB.face_centers(aabb)
	if center:
		result.append(xAABB.center(aabb))
	return result

static func get_snap_translation(from, to, snap_distance, axes=[0,1], default_value=Vector2.ZERO): #both from and to are an array of points
	var result = default_value
	for x in from:
		for y in to:
			var delta = y - x
			if axes.all(func(i): return abs(delta[i]) <= snap_distance):
				for i in axes:
					result[i] = delta[i]
				return result
	return result

func _process(delta):
	if not enabled or not Engine.is_editor_hint():
		return
	var selection = EditorInterface.get_selection().get_selected_nodes()
	var aabbs = get_children().filter(func(x): return x not in selection).map(func(x): return x3D.aabb(x))

	var axes_groups = []
	for k in _axes:
		if _axes[k]:
			axes_groups.append(xArray.indices(['X', 'Y', 'Z'], func(x): return x in k))

	for cur in selection:
		if cur.get_parent() != self:
			continue
		for tar in aabbs:
			var from = get_points(x3D.aabb(cur), from_corner, from_mid_edge, from_face_centers, from_center)
			var to = get_points(tar, to_corner, to_mid_edge, to_face_centers, to_center)
			for axes in axes_groups:
				cur.global_position += get_snap_translation(from, to, snap_distance, axes, Vector3.ZERO)
