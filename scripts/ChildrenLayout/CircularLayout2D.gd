extends ChildrenLayout

class_name CircularLayout2D

@export var radius = 10
@export var center = Vector2.ZERO
@export var speed = 1
var _cell_size

func _ready():
	_cell_size = (PI * 2) / (get_children().filter(func(x): return x.visible).size() if ignore_inactive else get_children().size())

func on_children_changed():
	super().on_children_changed()
	_ready()

func update_child(delta, x, i):
	var target = xMath.polar_to_cartesian(radius, _cell_size * i) + center
	if Engine.is_editor_hint():
		x.position = target
	else:
		x.position = x.position.move_toward(target, speed)
	return x.position == target
