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

static func random_range(min, max):
	var result = Vector3.ZERO
	for i in range(3):
		result[i] = randf_range(min[i], max[i])
	return result

static func random_in_sphere(r):
	return spherical_to_cartesian(randf_range(0, r), randf_range(0, 2 * PI), randf_range(0, 2 * PI))

static func random_on_sphere(r):
	return spherical_to_cartesian(r, randf_range(0, 2 * PI), randf_range(0, 2 * PI))

static func cartesian_to_spherical(x, y, z) -> Vector3:
	var r = sqrt(x * x + y * y + z * z)
	var theta = atan2(sqrt(x * x + y * y), z)
	var phi = atan2(y, x)
	return Vector3(r, theta, phi)

static func spherical_to_cartesian(r, theta, phi) -> Vector3:
	var x = r * sin(theta) * cos(phi)
	var y = r * sin(theta) * sin(phi)
	var z = r * cos(theta)
	return Vector3(x, y, z)
