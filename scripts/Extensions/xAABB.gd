class_name xAABB #axis-aligned minimum bounding box

static func min_max(min, max): return AABB(min, max - min)

static func aabb(a, b):
	return min_max(xVector3.minv(a.position, b.position), xVector3.maxv(a.end, b.end))

static func corners(rect): #bl, tl, br, tr
	var result = []
	for i in range(3):
		for j in range(3):
			for k in range(3):
				result.append(xRect2.denormalize_point(rect, Vector3(i,j,k)))
	return result

static func similarity(a, b):
	var count = 0
	for i in range(3):
		if a[i] == b[i]:
			count += 1
	return count

static func edges(rect, type=2): #0 diagonals, 1 face diagonals, 2 edges
	var result = []
	var vertices = corners(rect)
	for i in range(vertices.size()-1):
		for j in range(i+1, vertices.size()):
			if similarity(vertices[i], vertices[j]) == 2:
				result += [vertices[i], vertices[j]]
	return result

static func mid_edges(rect):
	var p = edges(rect)
	return range(12).map(func(i): return (p[i*2] + p[i*2+1]) * 0.5)

static func face_centers(rect):
	var p = edges(rect, 1)
	return xArray.to_distinct(range(12).map(func(i): return (p[i*2] + p[i*2+1]) * 0.5))

static func center(rect):
	return xRect2.denormalize_point(rect, Vector3.ONE * 0.5)
