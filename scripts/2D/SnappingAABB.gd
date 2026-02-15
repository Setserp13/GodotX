@tool
extends Node2D

class_name SnappingAABB

@export var snap_distance = 10

@export var x = true:
	set(value):
		x = value
		if x:
			xy = false

@export var y = true:
	set(value):
		y = value
		if y:
			xy = false

@export var xy = true:
	set(value):
		xy = value
		if xy:
			x = false
			y = false

@export var from_corner = true
@export var from_mid_edge = true
@export var from_center = true

@export var to_corner = true
@export var to_mid_edge = true
@export var to_center = true

@export var enabled = true

func get_points(aabb, corner, mid_edge, center):
	var result = []
	if corner:
		result += xRect2.corners(aabb)
	if mid_edge:
		result += xRect2.mid_edges(aabb)
	if center:
		result.append(xRect2.center(aabb))
	return result

static func get_snap_translation(from, to, snap_distance, axes=[0,1]): #both from and to are an array of points
	var result = Vector2.ZERO
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
			var from = get_points(x2D.aabb(cur), from_corner, from_mid_edge, from_center)
			var to = get_points(tar, to_corner, to_mid_edge, to_center)
			"""if xy:
				cur.global_position += get_snap_translation(from, to, snap_distance)
			else:
				if x:
					cur.global_position += get_snap_translation(from, to, snap_distance, [0])
				if y:
					cur.global_position += get_snap_translation(from, to, snap_distance, [1])"""
			var axes_groups = []
			if xy:
				axes_groups.append([0,1])
			else:
				if x:
					axes_groups.append([0])
				if y:
					axes_groups.append([1])
			for axes in axes_groups:
				cur.global_position += get_snap_translation(from, to, snap_distance, axes)
