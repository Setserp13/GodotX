class_name Cup

var _items
var _capacity : int

func _init(capacity):
	_capacity = capacity
	_items = []

func add(item):
	if _items.size() < _capacity:
		_items.append(item)
