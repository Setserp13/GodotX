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

func byCellCount(size, cellCount): return byCellSize(size, size / cellCount)

func byCellSize(size, cellSize):
	var result = []
	for x in xMath.rangef(0, size[0], cellSize[0]):
		for y in xMath.rangef(0, size[1], cellSize[1]):
			result.append(Rect2(x, y, min(cellSize[0], size[0] - x), min(cellSize[1], size[1] - y)))
	return result
