@tool
extends ControlLayout

@export var child_size : Vector2 = Vector2(0.5, 0.1)   # 50% of screen width and 10% of screen height

func update(nodes, screen_rect):
	#print('aaa')
	for i in range(nodes.size()):
		var x = nodes[i]
		x.size = screen_rect.size * child_size
		var position = Vector2.ZERO
		position[axis] = screen_rect.size[axis] * (child_size[axis] + gap) * i
		x.position = position
