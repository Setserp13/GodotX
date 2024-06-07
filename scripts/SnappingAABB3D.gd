@tool
extends Node

class_name SnappingAABB3D

@export var snap_distance = 10

@export var x = true:
	set(value):
		x = value
		if value:
			xy = false
			xz = false
			xyz = false
			
@export var y = true:
	set(value):
		y = value
		if value:
			xy = false
			yz = false
			xyz = false

@export var z = true:
	set(value):
		z = value
		if value:
			xz = false
			yz = false
			xyz = false

@export var xy = true:
	set(value):
		xy = value
		if value:
			x = false
			y = false
			xyz = false

@export var xz = true:
	set(value):
		xz = value
		if value:
			x = false
			z = false
			xyz = false

@export var yz = true:
	set(value):
		yz = value
		if value:
			y = false
			z = false
			xyz = false

@export var xyz = true:
	set(value):
		xyz = value
		if value:
			x = false
			y = false
			z = false
			xy = false
			xz = false
			yz = false

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
	var aabbs = get_children().filter(func(x): return x not in selection).map(func(x): return x2D.aabb(x))
	for cur in selection:
		if cur.get_parent() != self:
			continue
		for tar in aabbs:
			var from = get_points(x2D.aabb(cur), from_corner, from_mid_edge, from_face_centers, from_center)
			var to = get_points(tar, to_corner, to_mid_edge, to_face_centers, to_center)
			var axes_groups = []
			if xyz:
				axes_groups.append([0,1,2])
			if xy:
				axes_groups.append([0,1])
			if xz:
				axes_groups.append([0,2])
			if yz:
				axes_groups.append([1,2])
			if x:
				axes_groups.append([0])
			if y:
				axes_groups.append([1])
			if z:
				axes_groups.append([2])
			for axes in axes_groups:
				cur.global_position += get_snap_translation(from, to, snap_distance, axes)
