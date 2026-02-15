@tool
extends TiledSprite

class_name TiledSpriteRegion

func _process(_delta):
	if region_enabled:
		var rect = xRect2.normalize_rect(Rect2(Vector2.ZERO, texture.get_size()), region_rect)
		#print(rect)
		material.set_shader_parameter('region', Vector4(rect.position.x, rect.position.y, rect.size.x, rect.size.y))
	else:
		material.set_shader_parameter('region', Vector4(0.0,0.0,1.0,1.0))
	super._process(_delta)

static func tile(sprite):
	var dir = 'res://addons/GodotX/scripts/2D/'
	sprite.material = xNode.create_node(ShaderMaterial, {'shader': load(dir + 'tiled_region.gdshader')})
	sprite.script = load(dir + 'TiledSpriteRegion.gd')
	return sprite
	
static func create(texture):
	return tile(xNode.create_node(Sprite2D, {'texture': texture}))
