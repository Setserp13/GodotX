class_name ObjectPool #object pooling

var prefab
var parent
var items = []
var instantiate = null

func _init(prefab, parent=null):
	self.prefab = prefab
	self.parent = parent

func pick():
	if items.size() > 0:
		return items.pop_at(0)
	var instance = prefab.duplicate(4) if instantiate == null else instantiate.call(prefab)
	if parent != null:
		#if parent != instance.get_parent():
		xNode.append_child(parent, instance)
	else:
		xNode.append_child(prefab.get_tree().root, instance)
	return instance

func release(item):
	if item in items:
		#print("Item is already in pool")
		return
	items.append(item)
