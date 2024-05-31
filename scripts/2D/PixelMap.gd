@tool
class_name PixelMap

extends Node2D

@export var texture_map : Texture2D
@export var enabled = false

func _process(delta):
	if not Engine.is_editor_hint():
		return
	if not enabled:
		return
	enabled = false
	for x in get_children():
		x.generate(texture_map)
