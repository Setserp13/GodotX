@tool
extends Node
class_name ControlLayout

@export var axis : int = 1
@export var pivot : Vector2 = Vector2(0.5, 0.5)
@export var position : Vector2 = Vector2(0.5, 0.5)
@export_range(0.0, 0.2)
var gap := 0.01            # 1% of screen height

func _process(delta):
	layout_children()

func layout_children():
	var parent = self if is_instance_of(self, Control) else self.get_parent()
	#print(parent)
	var screen_rect = xNode.ancestors_of_type(parent, Control)[-1].get_global_rect()
	var siblings = xNode.children_of_type(parent, Control)
	
	siblings = siblings.filter(func(x): return x.visible)
	if siblings.size() == 0:
		return
	
	update(siblings, screen_rect)

	#var bounds = xControl.aabb(parent)
	var bounds = siblings.map(func(x): return x.get_global_rect()).reduce(xRect2.aabb)
	var delta = xRect2.denormalize_point(screen_rect, position) - xRect2.denormalize_point(bounds, pivot)
	for x in siblings:
		x.global_position += delta

func update(nodes, screen_rect):
	pass
