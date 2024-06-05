@tool
class_name PixelMap

extends Node#2D

@export var texture_map : Texture2D
@export var enabled = false

func _process(delta):
	if not Engine.is_editor_hint():
		return
	if not enabled:
		return
	enabled = false
	for x in get_children():
		if x is PixelMapItem and not x.ignore:
			x.generate(texture_map)
	#var bounds = xNode.get_or_add_component(self, Bounds2)
	#print(bounds)
	#bounds.rect = x2D.aabb(self)
