@tool
extends Sprite2D

class_name TiledSprite

@export var tiling_per_scale = Vector2.ONE

@export var cell_size = Vector2.ONE * 100
@export var use_cell_size = false
@export var global = true

func _process(_delta):
	var tiling = global_scale if global else scale
	if use_cell_size:
		tiling = x2D.get_global_size(self) / cell_size
	material.set_shader_parameter('tiling', tiling * tiling_per_scale)

static func tile(sprite):
	var dir = 'res://addons/GodotX/scripts/2D/'
	sprite.material = xNode.create_node(ShaderMaterial, {'shader': load(dir + 'tiled.gdshader')})
	sprite.script = load(dir + 'TiledSprite.gd')
	return sprite
	
static func create(texture):
	return tile(xNode.create_node(Sprite2D, {'texture': texture}))
