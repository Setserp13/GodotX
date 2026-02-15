class_name Rect

var position
var size

func _init(position, size):
	self.position = position
	self.size = size

static func min_max(min, max): return Rect.new(min, max - min)
