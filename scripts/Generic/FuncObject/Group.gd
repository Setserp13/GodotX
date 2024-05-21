extends Tweening

class_name Group

var finished = false
var items #a FuncObject array
var loops = 0

func _init(items=null):
	self.items = [] if items == null else items
	self.t = 0
	
func add(obj):
	items.append(obj)
	return self

func set_loops(value=INF):
	loops = value
	return self

func reset():
	finished = false
	for x in items:
		x.reset()

func has_finished():
	#print(finished)
	return finished

func invoke(delta):
	t = items.map(func(x): return x.t).max()
	update.invoke(t)
	finished = true
	for x in items:
		var result = x.has_finished()
		if not result:
			x.invoke(delta)
		finished = finished and result
	if finished:
		if loops > 0:
			if loops < INF:
				loops -= 1
			reset()
			finished = false
	return has_finished()
