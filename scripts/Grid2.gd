class_name Grid2

var offset = Vector2.ZERO
var cell_size = Vector2.ONE * 100
var cell_gap = Vector2.ZERO

func _init(offset, cell_size, cell_gap=Vector2.ZERO):
	self.offset = offset
	self.cell_size = cell_size
	self.cell_gap = cell_gap

func cell_to_point(value):
	return self.offset + (self.cellSize + self.cellGap) * value

func point_to_cell(value):
	return ((value - self.offset) / (self.cellSize + self.cellGap)).floor()
	
func cell(i, j):
	return Rect2(self.cell_to_point(Vector2(i,j)), self.cell_size)

static func get_cell(size, cell_count, index):
	var cell_size = size / cell_count
	return Rect2(cell_size * index, cell_size)

static func by_cell_count(size, cell_count): return by_cell_size(size, size / cell_count)

static func by_cell_size(size, cell_size):
	var result = []
	for x in xMath.rangef(0, size[0], cell_size[0]):
		for y in xMath.rangef(0, size[1], cell_size[1]):
			result.append(Rect2(x, y, min(cell_size[0], size[0] - x), min(cell_size[1], size[1] - y)))
	return result
