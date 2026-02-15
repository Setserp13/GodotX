class_name xDict

static func difference(a, b):
	var c = {}
	for k in a:
		if (k in b and a[k] != b[k]) or k not in b:
			c[k] = a[k]
	return c
