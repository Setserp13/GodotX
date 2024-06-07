@tool
extends Node2D

class_name SnappingGrid

@export var offset = Vector2.ZERO
@export var cell_size = Vector2.ONE * 100
@export var enabled = true

func _process(delta):
	if not enabled:
		return
	for x in get_children():
		x.position = (x.position / cell_size).floor() * cell_size
