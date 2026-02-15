class_name xMath

static func repeat(value: float, length: float) -> float:
	return value - floor(value / length) * length

"""static func ping_pong(value: float, length: float) -> float:
	var t = repeat(value, length * 2)
	return length - abs(t - length)"""

#static func lerp(a, b, t): return a * (1 - t) + b * t

#static func inverse_lerp(a, b, c): return (c - a) / (b - a)

static func arc(c, s): #cos, sin
	var result = acos(c)
	if s < 0:
		result = 2 * PI - result
	return result

static func distance(a, b):
	return abs(a - b) if (a is int or a is float) else a.distance_to(b)

static func isclose(a: Variant, b: Variant, epsilon := 0.001) -> bool:
	return distance(a, b) < epsilon

static func duration(start, stop, speed, metric=null): #use this to create speed based tweens
	metric = func(a, b): return distance(a, b) if metric == null else metric
	return metric.call(start, stop) / speed

static func ease_toward(current: Variant, target: Variant, delta: float, ease := 1.0) -> Variant:
	var t := clamp(delta / xMath.distance(current, target), 0.0, 1.0) if target != current else 1.0
	#print(target, current)
	t = ease(t, ease)  # Godot's built-in easing function
	return lerp(current, target, t)

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
	return range(n).map(func(i): return xMath.polar_to_cartesian(r, start + size * (float(i) / float(n-1))))



static func multi_lerp(arr, t):
	var total = arr.size() - 1
	var f_index = t * total
	var i0 = int(f_index)
	var i1 = min(i0 + 1, total)
	var alpha = f_index - i0
	return lerp(arr[i0], arr[i1], alpha)

static func closest(object, others, distance=func(x, y): return abs(x - y)):
	var min_dist = INF
	var result = null
	for x in others:
		var dist = distance.call(object, x)
		if dist < min_dist:
			min_dist = dist 
			result = x
	return result

static func combinations(arr: Array, n: int) -> Array:
	if n == 0:
		return [[]]
	if arr.is_empty():
		return []
	
	var result = []
	for i in range(arr.size()):
		var head = arr[i]
		var tail = arr.slice(i + 1, arr.size())
		for combo in combinations(tail, n - 1):
			result.append([head] + combo)
	return result


#RANDOM
static func random_on_arc(radius, start, size):
	return polar_to_cartesian(radius, randf_range(start, start + size))
	
static func random_on_circle(radius):
	return random_on_arc(radius, 0.0, TAU)
	
static func random_in_annulus_sector(inner_radius, radius, start, size):
	return random_on_arc(lerp(inner_radius, radius, sqrt(randf())), start, size)

static func random_in_annulus(inner_radius, radius):
	return random_in_annulus_sector(inner_radius, radius, 0.0, TAU)

static func random_in_circle(radius):
	return random_in_annulus(0.0, radius)
