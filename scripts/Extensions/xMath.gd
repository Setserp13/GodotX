class_name xMath

static func arc(c, s): #cos, sin
	var result = acos(c)
	if s < 0:
		result = 2 * PI - result
	return result

static func distance(a, b): return abs(a - b)

static func duration(start, stop, speed): #use this to create speed based tweens
	return distance(start, stop) / speed

static func invert(value):
	if value == 0:
		return INF
	else:
		return 1.0 / value

static func polar_to_cartesian(radius, angle): return Vector2(cos(angle), sin(angle)) * radius

static func cartesian_to_polar(x, y): return Vector2(x.distance_to(y), atan2(y, x))

static func circumradius(n, s): return 0 if n < 2 else s / (2 * sin(PI / n))
