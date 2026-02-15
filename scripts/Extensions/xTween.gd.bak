class_name xTween

static func do_property(object, property, final_val, duration):
	var tween = object.get_tree().create_tween()
	tween.tween_property(object, property, final_val, duration)
	return tween

static func tween_path(tween, node, property, final_vals, duration):
	for x in final_vals:
		tween.tween_property(node, property, x, duration)

static func do_shader_parameter(tween, material, name, final_val, duration):
	var method = func(x): material.set_shader_parameter(name, x)
	tween.tween_method(method, material.get_shader_parameter(name), final_val, duration)

static func do_shader_vector_component(tween, material, vector_name, component_index, final_val, duration):
	var method = func(x): xMaterial.set_shader_vector_component(material, vector_name, component_index, x)
	tween.tween_method(method, material.get_shader_parameter(vector_name)[component_index], final_val, duration)

static func fade(tween, sprite, final_val, duration=0.3, color_name='tint'):
	do_shader_vector_component(tween, sprite.material, color_name, 3, final_val, duration)

static func flip(tween, sprite, other_face, duration, ignore_equal_face=true):
	if sprite.texture != other_face or not ignore_equal_face:
		var half_duration = duration * 0.5
		var _prev_scale = sprite.scale.x
		tween.tween_property(sprite, 'scale:x', 0, half_duration)
		tween.tween_callback(func(): sprite.texture = other_face)
		tween.tween_property(sprite, 'scale:x', _prev_scale, half_duration)
