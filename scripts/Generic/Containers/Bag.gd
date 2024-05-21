class_name Bag

var _items  #Underlying Set
var _count  #Multiplicity
var items:
	get:
		return _items

func size(): return xArray.sum(_count)

func _init(array):
	_items = []
	_count = []
	add_range(array)
		

func add(item, count=1):
	var index = _items.find(item)
	if index > -1:
		_count[index] += count
	else:
		_items.append(item)
		_count.append(1)
	
func add_range(items):
	for x in items:
		add(x)

func clear():
	_items.clear()
	_count.clear()

func count(item):
	var index = _items.find(item)
	return _count[index] if index > -1 else 0
		
func insert(index, item, count=1):
	var idx = _items.find(item)
	if idx > -1:
		_count[idx] += count
	else:
		_items.insert(index, item)
		_count.insert(index, 1)

func remove(item, count=1):
	var index = _items.find(item)
	if index > -1:
		remove_at(index, count)

func remove_at(index, count=1):
	if _count[index] > count:
		_count[index] -= count
	else:
		_items.remove_at(index)
		_count.remove_at(index)

func set_count(item, value):
	var index = _items.find(item)
	if index > -1:
		set_count_at(index, value)
	else:
		if value > 0:
			add(item, value)

func set_count_at(index, value):
	if value > 0:
		_count[index] = value
	else:
		remove_at(index, _count[index])

func sort_custom(comparison):
	var items_copy = _items.duplicate()
	_items.sort_custom(comparison)
	var count_copy = _items.duplicate()
	for i in range(_count.size()):
		_count[i] = count_copy[items_copy.find(_items[i])]

static func intersection(bag, other_bag):
	var result = bag.duplicate()
	for i in range(result.size()):
		result.set_count_at(i, min(result.count[i], other_bag.get_count(result.items[i])))
	return result
