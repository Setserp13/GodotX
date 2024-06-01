extends CircularLayout2D

class_name AngularLayout2D

@export var min = 7 * PI / 12 #from 0 to 2PI
@export var size = -PI / 6 #from -2PI to 2PI
@export var translation_after_highlighted = -0.05 #from -2PI to 2PI
#@export var z_delta = -0.01

func get_rotation(i): return angle - PI / 2
