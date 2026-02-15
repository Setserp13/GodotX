@tool
extends Node

class_name NormalizedControl

@export var normalized_position = Vector2(0.5, 0.5)
@export var normalized_pivot = Vector2(0.5, 0.5)
@export var normalized_size = Vector2.ONE
@export var ignore_size = true

func _process(delta):
	var control = self if is_instance_of(self, Control) else self.get_parent()
	update(control)

func update(node):
	if not ignore_size:
		node.size = node.get_parent().get_global_rect().size * normalized_size
	var global_position = xRect2.denormalize_point(node.get_parent().get_global_rect(), normalized_position)
	xControl.set_global_position(node, global_position, normalized_pivot)


"""@export var position = Vector2.ZERO
@export var pivot = Vector2(0.5, 0.5)

func _process(delta):
	update(get_parent())

func update(control):
	control.position = position - control.size * pivot
	control.pivot_offset = control.size * pivot"""
