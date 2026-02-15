class_name xTween

static func do_property(object, property, final_val, duration):
	var tween = object.get_tree().create_tween()
	tween.tween_property(object, property, final_val, duration)
	return tween



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

static func write(tween: Tween, label: Label, text: String, chunk_duration: float, chunk_type = 0):	#0 for char and 1 for word
	if chunk_type == 0:
		tween.tween_method(func(value): label.text = xString.substrf(text, 0.0, value), 0.0, 1.0, text.length() * chunk_duration)
	else:
		#var words = text.split(" ", true)
		var words = text.split("\\s+", true)
		tween.tween_method(func(value): label.text = " ".join(words.slice(0, int(round(value * words.size())))), 0.0, 1.0, words.size() * chunk_duration)

static func write_all(tween: Tween, label: Label, texts, chunk_duration: float, delay: float, chunk_type = 0):
	for x in texts:
		write(tween, label, x, chunk_duration, chunk_type)
		tween.tween_interval(delay)

static func move_property(tween, node, property, end_value, speed, start_value=null):	#duration, speed_based = true):
	if start_value == null:
		start_value = xObject.get_property(node, property)
	var duration = xMath.duration(start_value, end_value, speed)
	tween.tween_property(node, property, end_value, duration)
	return tween

static func tween_path(tween, node, property, final_vals, duration, ease = Tween.EASE_IN_OUT):
	for x in final_vals:
		tween.tween_property(node, property, x, duration).set_ease(ease)

static func move_along(node, property, end_values, speed, ease := Tween.EASE_IN_OUT, loops=0, on_complete=func(): pass):
	var tween = node.create_tween()
	move_property(tween, node, property, end_values[0], speed).set_ease(ease)
	# When the first move finishes...
	tween.tween_callback(func():
		var tween2 = move_along_loop(node, property, end_values, speed, ease).set_loops(loops)
		tween2.tween_callback(on_complete)
	)

static func move_along_loop(node, property, end_values, speed, ease := Tween.EASE_IN_OUT, start_index = 0):
	var tween = node.create_tween()
	for i in range(end_values.size()):
		var index = (start_index + i) % end_values.size()
		move_property(tween, node, property, end_values[(index + 1) % end_values.size()], speed, end_values[index]).set_ease(ease)	#USE CALL BACK WHEN FUNC ENDS, TO BETTER CALCULATE START
	return tween

static func callback(node: Node, method: Callable, delay: float):
	var tween = node.get_tree().create_tween()
	tween.tween_callback(method).set_delay(delay)
	return tween

static func teleport(tween, body, target, duration=.2):
	var original_scale = body.scale
	tween.tween_property(body, 'scale', Vector2.ZERO, duration * 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_callback(func (): body.position = target)
	tween.tween_property(body, 'scale', original_scale, duration * 0.5).set_trans(Tween.TRANS_BOUNCE)



static func flash(tween, flash_rect, flash_time=0.2, fade_time=0.4):
	# Full flash
	tween.tween_callback(func():
		flash_rect.modulate.a = 1.0
		flash_rect.visible = true
		)
	# animate fade-out
	tween.tween_property(flash_rect, "modulate:a", 0.0, fade_time)\
		 .set_trans(Tween.TRANS_SINE)\
		 .set_ease(Tween.EASE_OUT)
	return tween
