class_name Collections

static func dict(keys, values):
	var result = {}
	for i in range(keys.size()):
		result[keys[i]] = values[i]
	return result
