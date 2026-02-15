@tool
extends ControlLayout

@export var scale_with_screen_size : bool = true
@export var child_sizes: Array[Vector2] = []


func update(nodes, screen_rect):
	if scale_with_screen_size:
		if Engine.is_editor_hint():
			# Running in the editor
			child_sizes = []
			for x in nodes:
				child_sizes.append(x.get_global_rect().size / screen_rect.size)
			#print(child_sizes)
		else:
			#print(child_sizes)
			# Running in the game
			for i in range(nodes.size()):
				nodes[i].size = screen_rect.size * child_sizes[i]
	
	var screen_center = xRect2.denormalize_point(screen_rect, position)
	var start = 0.0
	var global_gap = screen_rect.size[axis] * gap
	#print(global_gap)
	for x in nodes:
		var pos = Vector2.ZERO
		pos[axis] = start
		start += x.get_global_rect().size[axis] + global_gap
		x.global_position = pos
		xControl.set_axis_global_position(x, 1 - axis, screen_center, 0.5)

