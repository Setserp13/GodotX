class_name TempList

var time
var items
var _deadlines
var dflt_lifetime

func _init(dflt_lifetime=.1):
	self.items = []
	self._deadlines = []
	self.time = 0
	self.dflt_lifetime = dflt_lifetime
	
func add(item, lifetime=dflt_lifetime):
	items.append(item)
	_deadlines.append(time + lifetime)

func remove_at(index):
	items.remove_at(index)
	_deadlines.remove_at(index)

func remove(item):
	var index = items.find(item)
	if index > -1:
		remove_at(index)

func clear():
	items.clear()
	_deadlines.clear()

func update(delta): #only call this one time per loop
	time += delta
	for i in range(items.size()-1, -1, -1):
		if time >= _deadlines[i]:
			remove_at(i)

func size():
	return items.size()
