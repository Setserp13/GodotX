class_name xSprite2D

static func create(parent : Node2D, texture : Texture2D, rect : Rect2): #rect is normalized
	var result = Sprite2D.new()
	result.texture = texture
	if rect != null:
		result.region_enabled = true
		result.region_rect = xRect2.denormalize_rect(Rect2(Vector2.ZERO, texture.get_size()), rect)
	return result
