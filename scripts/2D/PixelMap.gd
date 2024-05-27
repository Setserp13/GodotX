@tool
class_name PixelMap

extends Node2D

enum RenderMode {CELLS, COLUMNS, ROWS, COLUMNS_BETTER, ROWS_BETTER}

@export var texture_map : Texture2D
@export var use_cell_size = false
@export var cell_size = Vector2(100, 100)
#@export var tile : Node2D
@export var tile : Texture2D
@export var render_mode = RenderMode.COLUMNS
@export var enabled = false

@export var top : Texture2D

static func instantiate_one(rect, parent, tile, cell_size=null):
	#PREFAB MUST BE AT SCALE 1
	#print(tile)
	var prefab = Sprite2D.new()
	prefab.texture = tile
	var body = xNode.create_child(parent, StaticBody2D)
	var sprite = TiledSprite.create(tile)
	xNode.append_child(body, sprite)
	sprite.centered = true
	if cell_size != null:
		x2D.set_global_size(sprite, cell_size)
	sprite.scale = rect.size
	body.position = rect.position * x2D.get_global_size(prefab)
	body.position += x2D.get_size(prefab) * 0.5 * rect.size * Vector2(1, -1)
	body.position[1] *= -1
	#body.position.y -= sprite.texture.size()[1]
	x2D.add_collider(body, RectangleShape2D)
	body.add_to_group('ground')
	body.name = prefab.name + '_' + str(rect.position[0]) + '_' + str(rect.position[1])
	#print(pixel)

static func instantiate_all(rects, parent, tile, cell_size=null):
	for i in range(rects.size()):
		instantiate_one(rects[i], parent, tile, cell_size)
		
func _process(delta):
	if not Engine.is_editor_hint():
		return
	if not enabled:
		return
	enabled = false
	xNode.clear(self)
	#foreach(texture.get_image(), inst)
	var image = texture_map.get_image()
	var get_rects = {
		RenderMode.CELLS: xImage.get_cells,
		RenderMode.COLUMNS: xImage.get_columns,
		RenderMode.ROWS: xImage.get_rows,
		RenderMode.COLUMNS_BETTER: xImage.get_columns_better,
		RenderMode.ROWS_BETTER: xImage.get_row_better
	}[render_mode]
	var rects = get_rects.call(image, func(x, i, j): return x == Color.BLACK)
	for i in range(rects.size()):
		rects[i].position[1] = image.get_size()[1] - rects[i].position[1] #'cuz godot is top to bottom
	#print(rects)
	instantiate_all(rects, self, tile)

	#GENERATE TOP
	for x in get_children():
		var sprite = Tiled9SlicedSprite.create(top) #9-sliced
		sprite.margins = Vector4(top.get_height(), 0, top.get_height(), 0)
		xNode.append_child(self, sprite)
		var tile_sprite = xNode.get_component(x, Sprite2D)
		x2D.set_global_size_component(sprite, 0, x2D.get_global_size(tile_sprite).x + top.get_height(), false)
		sprite.global_position = x2D.normalized_to_global_point(tile_sprite, Vector2(0.5, 0))
	"""var top_rects = xImage.get_cells(image, func(x, i, j):
		return x == Color.BLACK and xImage.get_pixel(image, i, j-1, Color.BLACK) != Color.BLACK
		)
	top_rects = xImage.merge_horizontally(top_rects)
	instantiate_all(top_rects, self, top)"""
	#print(top_rects)
