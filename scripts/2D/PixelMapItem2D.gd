@tool
extends PixelMapItem

class_name PixelMapItem2D

@export var tile : Texture2D
@export var slicing = Vector2.ONE 
@export var tiling_per_scale = Vector2.ONE
@export var use_cell_size = false
@export var cell_size = Vector2(100, 100)
@export var top : Texture2D

static func set_rect(rect, body, cell_size=null):
	var sprite = xNode.get_component(body, Sprite2D)
	var base_size = x2D.get_region_size(sprite) if cell_size == null else cell_size

	sprite.centered = true
	if cell_size == null:
		sprite.scale = rect.size
	else:
		sprite.use_cell_size = true
		sprite.cell_size = cell_size
		x2D.set_global_size(sprite, cell_size * rect.size)
	body.position = rect.position * base_size
	body.position += base_size * 0.5 * rect.size * Vector2(1, -1)
	body.position[1] *= -1

static func instantiate_one(rect, parent, tile, tiling_per_scale=Vector2.ONE, region_rect = null, collision_type=StaticBody2D, cell_size=null):
	var sprite = TiledSpriteRegion.create(tile)#TiledSprite.create(tile)
	var body = null
	if collision_type == null:
		body = sprite
		xNode.append_child(parent, sprite)
	else:
		body = xNode.create_child(parent, collision_type)
		xNode.append_child(body, sprite)
	sprite.texture_filter = parent.texture_filter
	sprite.tiling_per_scale = tiling_per_scale
	if region_rect != null:
		sprite.region_enabled = true
		sprite.region_rect = region_rect
	set_rect(rect, body, cell_size)
	#body.position.y -= sprite.texture.size()[1]
	if collision_type == null:
		var collider = xNode.create_child(parent, CollisionShape2D, {'shape': RectangleShape2D.new()})
		x2D.fit_collider_to_sprite(collider, sprite)
		parent.add_to_group('ground')
	else:
		x2D.add_collider(body, RectangleShape2D)
		body.add_to_group('ground')

static func instantiate_all(rects, parent, tile, tiling_per_scale=Vector2.ONE, slicing = null, collision_type=StaticBody2D, cell_size=null):
	var region_rect = slicing
	for i in range(rects.size()):
		if slicing is Vector2:
			var index = Vector2.ZERO
			for j in range(2):
				index[j] = randi_range(0, slicing[j] - 1)
			region_rect = Grid2.get_cell(tile.get_size(), slicing, index)
			#print([tile.get_size(), index, region_rect])
		instantiate_one(rects[i], parent, tile, tiling_per_scale, region_rect, collision_type, cell_size)

func generate(texture_map):
	xNode.clear(self)
	var rects = get_rects(render_mode, texture_map.get_image(), func(x, i, j): return x == color)
	instantiate_all(rects, self, tile, tiling_per_scale, slicing, Area2D if collision_mode == CollisionMode.AREA else StaticBody2D if collision_mode == CollisionMode.BODY else null, cell_size if use_cell_size else null)

	if top == null:
		return

	#GENERATE TOP
	for x in get_children():
		var sprite = Tiled9SlicedSprite.create(top) #9-sliced
		sprite.margins = Vector4(top.get_height(), 0, top.get_height(), 0)
		xNode.append_child(self, sprite)
		var tile_sprite = xNode.get_component(x, Sprite2D)
		x2D.set_global_size_component(sprite, 0, x2D.get_global_size(tile_sprite).x + top.get_height(), false)
		sprite.global_position = x2D.normalized_to_global_point(tile_sprite, Vector2(0.5, 0))
