@tool

extends Node

class_name ChildrenLayout

@export var enabled = true
@export var disable_when_finished = false
@export var ignore_inactive = true

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
	return true
