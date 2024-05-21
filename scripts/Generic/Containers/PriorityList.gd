class_name PriorityList

"""static func enqueue(list, item):
	list.insert(list.find(func(x): return item.order <= item.order), item)

static func push(list, item):
	list.insert(list.find(func(x): return item.order < item.order), item)

static func enqueue(list, item):
	list.insert(list.find(func(x): return item.order.compare_to(item.order) < 1), item)

static func push(list, item):
	list.insert(list.find(func(x): item.order.compare_to(item.order) < 0), item)"""

var _items
var _order

func size(): return _items.size()

func _init():
	_items = []
	_order = []
	
func add(item, order=0):
	_items.add(item)
	_order.add(order)

func clear():
	_items.clear()
	_order.clear()

func insert(index, item, order=0):
	_items.insert(index, item)
	_order.insert(index, order)

func remove(item):
	var index = _items.find(item)
	if index > -1:
		remove_at(index)
	return index > -1
	
func remove_at(index):
	_items.remove_at(index)
	_order.remove_at(index)
	
func enqueue(item, order=0):
	insert(_order.find(func(x): return order <= x, _order.size()), item, order)
	
func push(item, order=0):
	insert(_order.find(func(x): return order < x, _order.size()), item, order)
	
func contains(item):
	return item in _items
	
func find(item):
	return _items.find(item)
