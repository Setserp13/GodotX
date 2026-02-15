@tool
extends Sprite2D

class_name Tiled9SlicedSprite

@export var margins = Vector4.ZERO

func _process(_delta):
	var size = x2D.get_global_size(self)
	material.set_shader_parameter('tiling', global_scale)
	material.set_shader_parameter("margins", margins)
	material.set_shader_parameter("size", size)

static func tile(sprite):
	var dir = 'res://addons/GodotX/scripts/2D/'
	sprite.material = xNode.create_node(ShaderMaterial, {'shader': load(dir + 'tiled9sliced.gdshader')})
	sprite.script = load(dir + 'Tiled9SlicedSprite.gd')
	return sprite
	
static func create(texture):
	return tile(xNode.create_node(Sprite2D, {'texture': texture}))
