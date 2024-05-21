extends FuncObject

class_name ClockBasedFuncObject

var t #can be either a timer (float) or a counter (int)

func _init(t=0):
	self.t = t

func reset():
	t = 0
