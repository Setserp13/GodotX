extends ClockBasedFuncObject

class_name Do

var duration
var action = Event1.new()
var count_based

func _init(callback, duration=1, count_based=false):
	self.duration = duration
	action.add(callback)
	self.count_based = count_based
	self.t = 0

func has_finished():
	return t >= duration

func invoke(delta):
	t = t + 1 if count_based else min(t + delta, duration)
	action.invoke(delta)
	return has_finished()
