class_name EventBase

var items = []

func _init(items=null):
	self.items = [] if items == null else items

func add(item): items.append(item)

func insert(index, item): items.insert(index, item)

func remove_at(index): items.remove_at(index)

func remove(item):
	var index = items.find(item)
	if index > -1:
		remove_at(index)

func clear(): items.clear()
