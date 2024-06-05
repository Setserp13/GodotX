@tool
extends PixelMapItem2D

class_name PixelMapItemBorder

func generate(texture_map):
	xNode.clear(self)
	#foreach(texture.get_image(), inst)
	var image = texture_map.get_image()
	var rects = get_rects.call(image, func(x, i, j):
		if x != color:
			return false
		for k in range(-1, 2):
			for l in range(-1, 2):
				if k == 0 and l == 0:
					continue
				if xImage.get_pixel(image, i+k, j+l) != color:
					return true
		return false)
	for i in range(rects.size()):
		rects[i].position[1] = image.get_size()[1] - rects[i].position[1] #'cuz godot is top to bottom
		#print(rects)
	instantiate_all(rects, self, tile, tiling_per_scale, slicing, Area2D if collision_mode == CollisionMode.AREA else StaticBody2D if collision_mode == CollisionMode.BODY else null, cell_size if use_cell_size else null)
