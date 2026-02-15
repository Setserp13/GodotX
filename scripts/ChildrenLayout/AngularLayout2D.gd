extends PropertyLayout

class_name AngularLayout2D

@export var min = 7 * PI / 12 #from 0 to 2PI
@export var size = -PI / 6 #from -2PI to 2PI
@export var translation_after_highlighted = -0.05 #from -2PI to 2PI
#@export var z_delta = -0.01

func _ready():
	property = 'rotation'

func get_target(i):
	var angle = float(i) / float(children().size())
	return angle - PI / 2
