class_name ChangeObserver

var prev
var getter
var value:
	get:
		var cur = getter.call()
		var delta = cur - prev
		prev = cur
		return delta
var dir:
	get:
		return sign(value)
var velocity:
	get:
		#print(value)
		return value / Performance.get_monitor(Performance.TIME_PROCESS)

func _init(getter):
	self.getter = getter
	self.prev = self.getter.call()
