class_name ChangeObserver

var prev
var getter
"""var value:
	get:
		var cur = getter.call()
		var delta = cur - prev
		prev = cur
		return delta"""
var delta:
	get:
		var cur = getter.call()
		var result = cur - prev
		prev = cur
		return result
var dir:
	get:
		return sign(delta)
var velocity:
	get:
		#print(delta)
		return delta / Performance.get_monitor(Performance.TIME_PROCESS)

func _init(getter):
	self.getter = getter
	self.prev = self.getter.call()
