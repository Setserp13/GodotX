@tool
extends Node

class_name NormalizedPivot

@export var value = Vector2.ZERO

func _process(delta):
	get_parent().pivot_offset = get_parent().size * value
