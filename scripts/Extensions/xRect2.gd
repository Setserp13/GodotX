class_name xRect2

static func normalize_point(rect, value): return (value - rect.position) / rect.size

static func denormalize_point(rect, value): return rect.position + rect.size * value

static func normalize_vector(rect, value): return value / rect.size

static func denormalize_vector(rect, value): return rect.size * value

static func normalize_rect(rect, value):
	return Rect2(normalize_point(rect, value), normalize_vector(rect, value))

static func denormalize_rect(rect, value):
	return Rect2(denormalize_point(rect, value), denormalize_vector(rect, value))

static func absolute_padding(rect, l=0.0, r=0.0, d=0.0, u=0.0):
	return Rect2(rect.position + Vector2(l, d), rect.size - Vector2(l + r, d + u))

static func relative_padding(rect, l=0.0, r=0.0, d=0.0, u=0.0):
	return absolute_padding(rect, l * rect.size.x, r * rect.size.x, d * rect.size.y, u * rect.size.y)

static func padding(rect, l=0.0, r=0.0, d=0.0, u=0.0, relative=true):
	if relative:
		return relative_padding(rect, l, r, d, u)
	else:
		return absolute_padding(rect, l, r, d, u)

static func bottom_left(rect): return denormalize_point(rect, Vector2(0,0))
static func bottom_right(rect): return denormalize_point(rect, Vector2(1,0))
static func top_left(rect): return denormalize_point(rect, Vector2(0,1))
static func top_right(rect): return denormalize_point(rect, Vector2(1,1))

static func bottom(rect): return [bottom_left(rect), bottom_right(rect)]
static func top(rect): return [top_left(rect), top_right(rect)]
static func left(rect): return [bottom_left(rect), top_left(rect)]
static func right(rect): return [bottom_right(rect), top_right(rect)]

static func corners(rect): #bl, tl, br, tr
	var result = []
	for i in range(2):
		for j in range(2):
			result.append(denormalize_point(rect, Vector2(i,j)))
	return result

static func left_right_coincide(a, b):
	return xArray.contains(left(a), right(b)) or xArray.contains(right(a), left(b))

static func bottom_top_coincide(a, b):
	return xArray.contains(bottom(a), top(b)) or xArray.contains(top(a), bottom(b))

static func min_max(min, max): return Rect2(min, max - min)

static func aabb(a, b): #axis-aligned minimum bounding box
	return min_max(xVector2.minv(a.position, b.position), xVector2.maxv(a.end, b.end))
