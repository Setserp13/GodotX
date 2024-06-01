@tool
extends PixelMapItem

class_name PixelMapItem16Sliced

@export var mask : Texture2D

"""func get_mask(image, predicate, i, j): #predicate is like (pixel) -> bool
	xMatrix.fromfun(3, 3, func(k, l):
		return 1 if predicate.call(xImage.get_pixel(image, i+(k-1), j+(l-1))) else 0
		)"""

func get_mask(image, predicate, i, j): #predicate is like (pixel) -> bool
	return [
		predicate.call(xImage.get_pixel(image, i-1, j)), #left
		predicate.call(xImage.get_pixel(image, i+1, j)), #right
		predicate.call(xImage.get_pixel(image, i, j-1)), #up #cuz top-down
		predicate.call(xImage.get_pixel(image, i, j+1)) #down
	]

func get_masks(): #mask must be a 4x4 texture
	var image = mask.get_image()
	var result = []
	for i in range(4):
		for j in range(4):
			result.append([
				xImage.get_pixel(image, i, j) == xImage.get_pixel(image, i-1, j),
				xImage.get_pixel(image, i, j) == xImage.get_pixel(image, i+1, j),
				xImage.get_pixel(image, i, j) == xImage.get_pixel(image, i, j-1),
				xImage.get_pixel(image, i, j) == xImage.get_pixel(image, i, j+1),
			])
	return result

func sliced16(image, predicate, slices): #predicate is like (pixel) -> bool
	var masks = get_masks()
	for i in range(masks.size()):
		var current_mask = masks[i]
		var slice = slices[i]
		var rects = xImage.get_rows_better(image, func(x, i, j):
			if not predicate.call(x):
				return false
			return current_mask == get_mask(image, predicate, i, j))
		for j in range(rects.size()):
			rects[j].position[1] = image.get_size()[1] - rects[j].position[1] #'cuz godot is top to bottom
		instantiate_all(rects, self, tile, tiling_per_scale, slice, Area2D if collision_mode == CollisionMode.AREA else StaticBody2D if collision_mode == CollisionMode.BODY else null, cell_size if use_cell_size else null)

func generate(texture_map):
	xNode.clear(self)
	var image = texture_map.get_image()
	sliced16(image, func(x): return x == color, get_cells(tile, Vector2(4,4)))
