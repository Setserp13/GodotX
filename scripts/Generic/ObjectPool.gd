class_name ObjectPool #object pooling

var prefab
var _pool = []

func _init(prefab):
	self.prefab = prefab

func pick():
	if _pool.size() > 0:
		return _pool.pop_at(0)
	return prefab.duplicate(4)

func release(item):
	_pool.append(item)
