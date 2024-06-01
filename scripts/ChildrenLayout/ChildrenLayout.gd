@tool

extends Node

class_name ChildrenLayout

@export var enabled = true
@export var disable_when_finished = false
@export var ignore_inactive = true
@export var immediate = false
@export var speed = 100
@export var angular_speed = 180

func on_children_changed():
	enabled = true

func _process(delta):
	if not enabled:
		return
	var has_finished = true
	var children = get_children().filter(func(x): return x.visible) if ignore_inactive else get_children()
	for i in range(children.size()):
		if not update_child(delta, children[i], i):
			has_finished = false
	if has_finished and disable_when_finished:
		enabled = false

func update_child(delta, x, i):
	var target = get_position(i)
	var target_rotation = get_rotation(i)
	if Engine.is_editor_hint() or immediate:
		x.position = target
		x.rotation = target_rotation
	else:
		x.position = x.position.move_toward(target, speed)
		x.rotation = move_toward(x.rotation, target_rotation, deg_to_rad(angular_speed))
	return x.position == target and x.rotation == target_rotation

#func get_target_properties(i): return {'position': Vector2.ZERO, 'rotation': 0.0}

func get_position(i): return Vector2.ZERO

func get_rotation(i): return 0.0
