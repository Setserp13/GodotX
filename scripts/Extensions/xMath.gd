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

static func rangef(start, stop, step):
	return range(ceil((stop - start) / step)).map(func(i): return start + step * i)

static func on_arc(n, r=1.0, start=0.0, size=2.0 * PI): #where start is the start angle and size is the angular size, using default start and size is equal to call on_circle
	return range(n).map(func(i): return xMath.polar_to_cartesian(r, start + s
