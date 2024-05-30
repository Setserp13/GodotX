class_name ObjectPool #object pooling

var prefab
var parent
var _pool = []

func _init(prefab, parent=null):
	self.prefab = prefab
	self.parent = parent

func pick():
	if _pool.size() > 0:
		return _pool.pop_at(0)
	return xNode.append_child(parent, prefab.duplicate(4))

func release(item):
	_pool.append(item)
