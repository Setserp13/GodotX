@tool
extends Sprite2D

class_name TiledSprite

@export var tiling_per_scale = Vector2.ONE

func _process(_delta):
	material.set_shader_parameter('tiling', global_scale / tiling_per_scale)

static func tile(sprite):
	var dir = 'res://addons/GodotX/scripts/2D/'
	sprite.material = xNode.create_node(ShaderMaterial, {'shader': load(dir + 'tiled.gdshader')})
	sprite.script = load(dir + 'TiledSprite.gd')
	return sprite
	
static func create(texture):
	return tile(xNode.create_node(Sprite2D, {'texture': texture}))
