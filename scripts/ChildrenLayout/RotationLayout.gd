extends PropertyLayout

class_name RotationLayout

var _cell_size

func _ready():
	property = 'rotation'

func get_target(i): return (_cell_size * i) - PI / 2
