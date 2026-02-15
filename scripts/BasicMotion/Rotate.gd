extends BasicMove
class_name Rotate

@export var angle := TAU

"""func get_length():
	return abs(angle)

func apply(t):
	self.rotation = angle * t"""

func _process(delta):
	self.rotation += speed * delta

