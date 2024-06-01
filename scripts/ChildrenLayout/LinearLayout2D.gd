extends ChildrenLayout

class_name LinearLayout2D

@export var immediate = false
@export var direction = Vector2.RIGHT #: Variant
@export var offset = 0
@export var cell_size = 1
@export var spacing = 0
@export var speed = 10
	
func update_child(delta, x, i):
	var target = direction * (offset + (cell_size + spacing) * i)
	if immediate:
		x.position = target
	else:
		x.position = x.position.move_toward(target, speed)
	return x.position == target
