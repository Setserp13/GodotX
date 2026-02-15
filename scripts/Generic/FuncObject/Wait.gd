extends ClockBasedFuncObject

class_name Wait

var duration

func _init(duration=0):
	self.duration = duration
	self.t = 0
	
func invoke(delta):
	t += delta
	return has_finished()

func has_finished():
	return t >= duration
