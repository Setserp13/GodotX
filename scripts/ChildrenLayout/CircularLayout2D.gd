extends PropertyLayout

class_name CircularLayout2D

@export var radius = 10
@export var center = Vector2.ZERO
var _cell_size

func _ready():
	_cell_size = (PI * 2) / children().size()

func on_children_changed():
	super().on_children_changed()
	_ready()

func get_target(i): return xMath.polar_to_cartesian(radius, _cell_size * i) + center
