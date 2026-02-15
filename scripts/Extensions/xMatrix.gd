class_name xMatrix

static func find_index(matrix, predicate):
	for i in range(matrix.size()):
		for j in range(matrix[i].size()):
			if predicate.call(matrix[i][j]):
				return Vector2i(i, j)
	return Vector2i(-1, -1)

static func foreach(array, action):
	for i in range(array.size()):
		for j in range(array[i].size()):
			action.call(array[i][j], i, j)

static func fromfun(width, height, fun):
	var result = []
	for i in range(width):
		var row = []
		for j in range(height):
			row.push_back(fun.call(i, j))
		result.push_back(row)
	return result

static func full(width, height, default_value):
	return fromfun(width, height, func(i, j): return default_value)

static func get_column(matrix, index):
	return xArray.fromfun(matrix.size(), func(i): return matrix[i][index])

static func index_of(matrix, item):
	return find_index(matrix, func(obj): return obj == item)

static func transpose(matrix):
	return fromfun(matrix.size(), matrix[0].size(), func(i, j): return matrix[j][i])

static func from_csv(content, sep=','):
	var result = []
	for x in content.split('\r\n'):
		if x == '':
			continue
		var row = []
		for y in x.split(sep):
			row.append(y)
		result.append(row)
	return result

