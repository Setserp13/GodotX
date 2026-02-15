class_name xVector2

static func clampv(value, min, max):
	for i in range(2):
		value[i] = clamp(value[i], min[i], max[i])
	return value

static func minv(a, b):
	var c = Vector2.ZERO
	for i in range(2):
		c[i] = min(a[i], b[i])
	return c

static func maxv(a, b):
	var c = Vector2.ZERO
	for i in range(2):
		c[i] = max(a[i], b[i])
	return c
	
static func duration(start, stop, speed): #use this to create speed based tweens
	return start.distance_to(stop) / speed

static func rotate(vector, angle):
	var c = cos(angle)
	var s = sin(angle)
	return Vector2(c * vector.x - s * vector.y, s * vector.x + c * vector.y)

static func angle(from, to):
	var a = from.normalized()
	var b = to.normalized()
	return xMath.arc(b.x, b.y) - xMath.arc(a.x, a.y)

static func stretch(v, delta, axis=0):
	var area = v.x * v.y
	v[axis] += delta
	v[1 - axis] = area / v[axis]
	return v
