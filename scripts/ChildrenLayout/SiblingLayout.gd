@tool
extends Node

class_name SiblingLayout

@export var enabled = true
@export var disable_when_finished = false
@export var ignore_inactive = true

func on_children_changed():
	enabled = true

func _process(delta):
	if not enabled:
		return
	var has_finished = true
	var children = children()
	for i in range(children.size()):
		if not update_child(delta, children[i], i):
			has_finished = false
	if has_finished and disable_when_finished:
		enabled = false

func children():
	var result = get_parent().get_children()
	result = result.filter(func(x): return x.visible) if ignore_inactive else result
	return filter_children(result)

func filter_children(children):
	return children.filter(func(x): return x is Node2D)

func update_child(delta, x, i):
	pass
