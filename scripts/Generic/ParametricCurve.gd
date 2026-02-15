class_name BezierCurve

#ANY VECTOR
static func bezier1(a, b, t): #LINEAR
	return (1 - t) * a + t * b
	
static func bezier2(a, b, c, t): #QUADRATIC
	var one_minus_t = 1 - t
	return one_minus_t * one_minus_t * a + 2 * one_minus_t * t * b + t * t * c
	
static func bezier3(a, b, c, d, t):  #CUBIC
	var one_minus_t = 1 - t
	return one_minus_t * one_minus_t * one_minus_t * a + 3 * one_minus_t * one_minus_t * t * b + 3 * one_minus_t * t * t * c + t * t * t * d
	
static func bezier1_deriv(a, b, t):
	return a + b
	
static func bezier2_deriv(a, b, c, t):
	var one_minus_t = 1 - t
	return 2 * one_minus_t * (b - a) + 2 * t * (c - b)
	
static func bezier3_deriv(a, b, c, d, t):
	var one_minus_t = 1 - t
	return 3 * one_minus_t * one_minus_t * (b - a) + 6 * one_minus_t * t * (c - b) + 3 * t * t * (d - c)
	
static func bezier(t, p): #GENERIC
	if p.Length == 1:
		return p[0]
	else:
		return (1 - t) * bezier(t, p.slice(0, p.size()-1)) + t * bezier(t, p.slice(1))

static func bezier_deriv(t, p):
	return bezier(t, xArray.fromfun(p.size()-1, func(i): return p.size() * p[i+1] - p[i]))


#VECTOR3
static func bezier_normal(t, p):
	var derivative = bezier_deriv(t, p)
	return derivative.cross(Quaternion.from_euler(Vector3.RIGHT * 90) * derivative)


static func get_points(step_count, p, curve=bezier): #can use bezier_derivative, bezier_normal and so on...
	var step = 1 / step_count
	return xArray.fromfun(step_count+1, func(i): return curve.call(step * i, p))



static func denormalize_point(vertices, point):
	var end_points = segment_weights(vertices) #end points are normalized
	for i in range(end_points.size()-1):
		if end_points[i] <= point and point <= end_points[i+1]:
			var t = inverse_lerp(end_points[i], end_points[i+1], point)
			return vertices[i].lerp(vertices[i+1], t)
	return Vector2.ZERO #point is out of the path

static func denormalize_points(vertices, points):
	return points.map(func(t): return denormalize_point(vertices, t))

static func get_points2(step_count, p, curve_fun=bezier): #get equidistant points
	var points = get_points(step_count, p, curve_fun)
	var step = 1 / step_count
	return denormalize_points(points, points.map(func(i): return step * i))

	
#MOVE BELOW TO A CLASS CALLED PATH


static func segment_weights(points):
	return xArray.weights(segment_lengths(points), length(points))

static func segment_lengths(points):
	return xArray.fromfun(points.size()-1, func(i): return points[i].distance_to(points[i+1]))

static func length(points):
	return(xArray.sum(segment_lengths(points)))
