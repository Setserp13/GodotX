class_name xAABB #axis-aligned minimum bounding box

static func min_max(min, max): return AABB(min, max - min)

static func aabb(a, b):
	return min_max(xVector3.minv(a.position, b.position), xVector3.maxv(a.end, b.end))
