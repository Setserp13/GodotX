extends Sprite2D

class_name SpriteSheet2D

@export var duration = 0.5
@export var sheets : Array[Texture2D] = []
@export var threshold : int = 1
var _regions = []
var tween
var _index
var index:
	get: return _index

func _ready():
	#print(sheets[0].get_image())
	_regions = sheets.map(func(x): return SpriteSheet2D.get_atlases(x.get_image(), threshold))
	print(_regions)
	region_enabled = true
	play(0)

func play(index, loops=INF):
	_index = index
	if tween != null:
		tween.kill()
	texture = sheets[index]
	tween = get_tree().create_tween()
	tween.bind_node(self)
	#print(_regions[index])
	tween_sprite_sheet(tween, self, _regions[index], duration, loops)
	return tween

static func tween_sprite_sheet(tween, sprite, regions, duration, loops=INF):
	var rate = float(duration) / float(regions.size())
	#print(rate)
	for x in regions:
		tween.tween_callback(func(): sprite.region_rect = x)
		#print(rate)
		tween.tween_interval(rate)
	tween.set_loops(loops)




static func get_atlases(image, threshold):
	var rects = xImage.find_indices(image, func(x, i, j): return x.a > 0).map(func(x): return Rect2(x, Vector2.ZERO))
	return xImage.merge_where(rects, func(x, y): return xRect2.chebyshev_distance(x, y) <= threshold) #return regions




"""#static func aabb(a, b):
#	return xRect2.min_max(xVector2.minv(a, b), xVector2.maxv(a, b))

static func aabb(array):
	return xRect2.min_max(array.reduce(xVector2.minv), array.reduce(xVector2.maxv))
	
static func get_atlases(image, threshold=1):
	var result = []
	var visited = xMatrix.full(image.get_width(), image.get_height(), false)
	for i in range(image.get_width()):
		for j in range(image.get_height()):
			var selection = fuzzy_select(image, Vector2i(i, j), func(x, i, j): return x.a > 0, threshold, visited)
			if selection.size() > 0:
				result.append(aabb(selection))
	#print(result)
	return result

static func fuzzy_select(image, start_point, predicate, threshold=1, visited=[]):
	var result = []
	if not in_range(image, start_point.x, start_point.y):
		return result
	if visited[start_point.x][start_point.y]:
		return result
	print(start_point)
	visited[start_point.x][start_point.y] = true
	if predicate.call(xImage.get_pixel(image, start_point.x, start_point.y), start_point.x, start_point.y):
		result.append(start_point)
	for i in range(-threshold, threshold+1):
		for j in range(-threshold, threshold+1):
			if i == 0 and j == 0:
				continue
			var point = Vector2i(start_point.x + i, start_point.y + j)
			result.append_array(fuzzy_select(image, point, predicate, threshold, visited))
	return result"""
