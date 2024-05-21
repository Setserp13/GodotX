class_name xImage

static func foreach(image, action):
	for i in range(image.get_size()[0]):
		for j in range(image.get_size()[1]):
			action.call(image.get_pixel(i, j), i, j)

static func find_indices(image, predicate):
	var result = []
	for i in range(image.get_size()[0]):
		for j in range(image.get_size()[1]):
			if predicate.call(image.get_pixel(i, j), i, j):
				result.append(Vector2i(i, j))
	return result
	
static func get_cells(image, predicate):
	return find_indices(image, predicate).map(func(x): return Rect2(x[0], x[1], 1, 1))

static func get_columns(image, predicate):
	var result = []
	for i in range(image.get_size()[0]):
		var gap = true
		for j in range(image.get_size()[1]):
			if predicate.call(image.get_pixel(i, j), i, j):
				if gap:
					result.append(Rect2(i, j, 1, 1))
					gap = false
				else:
					result[-1].size[1] += 1
			else:
				if not gap:
					gap = true
	return result
	
static func get_rows(image, predicate):
	var result = []
	for i in range(image.get_size()[1]):
		var gap = true
		for j in range(image.get_size()[0]):
			if predicate.call(image.get_pixel(j, i), j, i):
				if gap:
					result.append(Rect2(j, i, 1, 1))
					gap = false
				else:
					result[-1].size[0] += 1
			else:
				if not gap:
					gap = true
	return result

static func get_columns_better(image, predicate):
	return merge_horizontally(get_columns(image, predicate))

static func get_row_better(image, predicate):
	return merge_vertically(get_rows(image, predicate))

static func get_pixel(image, i, j, default_value=null):
	if i > -1 and i < image.get_width() and j > -1 and j < image.get_height():
		return image.get_pixel(i, j)
	return default_value

static func merge_horizontally(rects):
	for i in range(rects.size()-1, 0, -1):
		for j in range(i-1, -1, -1):
			if xRect2.left_right_coincide(rects[i], rects[j]):
				rects[j] = xRect2.aabb(rects[i], rects[j])
				rects.remove_at(i)
				break
	return rects
	
static func merge_vertically(rects):
	for i in range(rects.size()-1, 0, -1):
		for j in range(i-1, -1, -1):
			if xRect2.bottom_top_coincide(rects[i], rects[j]):
				rects[j] = xRect2.aabb(rects[i], rects[j])
				rects.remove_at(i)
				break
	return rects
