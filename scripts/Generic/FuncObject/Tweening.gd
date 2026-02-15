extends ClockBasedFuncObject

class_name Tweening

var update = Event1.new()

func on_update(callback):
	update.add(callback)
	return self
