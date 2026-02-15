class_name xObject

static func try_call(obj, method, args):
	if obj.has_method(method):
		obj.callv(method, args)

static func get_property(obj, path: String):
	var parts = path.split(":")
	var value = obj
	for part in parts:
		value = value[part]
	return value
	
static func set_property(obj, path: String, new_value):
	var parts = path.split(":")
	var target = obj
	for i in range(parts.size() - 1):
		target = target[parts[i]]
	target.set(parts[-1], new_value)
