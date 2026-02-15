extends Camera2D

class_name CursorRayCast2D

static var instance

var _target = Value.new(null)
var _pressed = Value.new(false)
var _cursor_position = Vector2.ZERO

func get_collider(raycast_hit):
	if raycast_hit == null or raycast_hit.size() == 0:
		return null
	raycast_hit = raycast_hit[0]
	if "collider" not in raycast_hit:
		return null
	return raycast_hit["collider"]

func _ready():
	instance = self
	_target.on_change.add(
		func(old, new):
			if get_collider(old) != get_collider(new):
				if get_collider(old) != null:
					xObject.try_call(get_collider(old), 'on_cursor_exit', [instance])
				if get_collider(new) != null:
					xObject.try_call(get_collider(new), 'on_cursor_enter', [instance])
	)
	_pressed.on_change.add(
		func(old, new):
			if old != new and get_collider(_target.value) != null:
				#print('cursor down' if new else 'cursor up')
				xObject.try_call(get_collider(_target.value), 'on_cursor_down' if new else 'on_cursor_up', [instance])
	)

static func get_intersections():
	var space_state = instance.get_world_2d().direct_space_state

	var point: Vector2 = instance.get_global_mouse_position()

	var query := PhysicsPointQueryParameters2D.new()
	query.position = point
	query.collide_with_areas = true
	query.collide_with_bodies = true
	# query.exclude = [instance]

	return space_state.intersect_point(query)

func _input(event):
	_cursor_position = event.position
	#print(_cursor_position)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed.value = event.pressed
	elif event is InputEventScreenTouch:
		_pressed.value = event.is_pressed()

func _process(delta):
	_target.value = get_intersections()
