class_name Tube

var _items
var _capacity : int

func _init(capacity):
	_capacity = capacity
	_items = []

func add(item):
	if _items.size() >= _capacity:
		_items.remove_at(_items.size()-1)
	_items.insert(0, item)
