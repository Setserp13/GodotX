class_name xObject

static func try_call(obj, method, args):
	if obj.has_method(method):
		obj.callv(method, args)
