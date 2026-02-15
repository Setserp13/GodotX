extends CanvasItem

class_name TextureScrolling

@export var speed = Vector2.RIGHT

func _process(delta):
	var offset = material.get_shader_parameter('offset')
	offset += speed * delta
	material.set_shader_parameter('offset', offset)
