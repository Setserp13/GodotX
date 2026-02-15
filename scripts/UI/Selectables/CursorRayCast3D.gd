extends Camera3D

class_name CursorRayCast3D

static var distance = 100000#INF

static var instance

var _target = Value.new(null)
var _pressed = Value.new(false)
var _cursor_position = Vector2.ZERO

func get_collider(raycast_hit):
	if raycast_hit == null or "collider" not in raycast_hit:
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

"""var _on_cursor_exit = Event1.new()
var _on_cursor_enter = Event1.new()
static func on_cursor_enter(callback): instance._on_cursor_enter.add(callback)
static func on_cursor_exit(callback): instance._on_cursor_exit.add(callback)"""

static func get_intersections():
	var space_state = instance.get_world_3d().direct_space_state
	#var from = instance._cursor_position
	#var to = from + instance.global_basis.z.normalized() * distance
	var from = instance.project_ray_origin(instance._cursor_position)
	var to = from + instance.project_ray_normal(instance._cursor_position) * distance
	var query = PhysicsRayQueryParameters3D.create(from, to)
	#query.exclude = [instance]
	return space_state.intersect_ray(query)

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
