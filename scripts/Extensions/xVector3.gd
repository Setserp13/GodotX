class_name xVector3

static func clampv(value, min, max):
	for i in range(3):
		value[i] = clamp(value[i], min[i], max[i])
	return value

static func minv(a, b):
	var c = Vector3.ZERO
	for i in range(3):
		c[i] = min(a[i], b[i])
	return c

static func maxv(a, b):
	var c = Vector3.ZERO
	for i in range(3):
		c[i] = max(a[i], b[i])
	return c
