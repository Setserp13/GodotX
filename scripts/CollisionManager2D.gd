extends Node #EventNode

class_name CollisionManager2D #manage all collisions and triggers of an object

var _on_collision_enter = Event1.new()
var _on_collision_exit = Event1.new()
var _collisions = []
var _on_trigger_enter = Event1.new()
var _on_trigger_exit = Event1.new()
var _triggers = []
var _body

func _ready():
	if _body == null:
		_body = get_parent()

func _process(delta):
	process_collisions()
	process_triggers()

func process_collisions():
	var collisions = x2D.get_collisions(_body)
	for x in _collisions.filter(func(x): return not collisions.any(func(y): return x.get_collider() == y.get_collider())):
		_on_collision_exit.invoke(x)
		xObject.try_call(x.get_collider(), 'on_collision_exit', [_body])
	for x in collisions.filter(func(x): return not _collisions.any(func(y): return x.get_collider() == y.get_collider())):
		_on_collision_enter.invoke(x)
		xObject.try_call(x.get_collider(), 'on_collision_enter', [_body])
	_collisions = collisions

func process_triggers():
	var triggers = x2D.get_intersecting_areas(xNode.get_component(_body, CollisionShape2D))
	for x in _triggers.filter(func(x): return x not in triggers):
		_on_trigger_exit.invoke(x)
		xObject.try_call(x, 'on_trigger_exit', [_body])
	for x in triggers.filter(func(x): return x not in _triggers):
		_on_trigger_enter.invoke(x)
		xObject.try_call(x, 'on_trigger_enter', [_body])
	_triggers = triggers







static func get_or_add(body): #if body already have one, just returns it
	var result = xNode.get_component(body, CollisionManager2D)
	if result == null:
		result = xNode.create_child(body, CollisionManager2D)#, {'_body': body})
	return result

static func on_collision_enter(body, callback):
	get_or_add(body)._on_collision_enter.add(callback)

static func on_collision_exit(body, callback):
	get_or_add(body)._on_collision_exit.add(callback)

static func on_trigger_enter(body, callback):
	get_or_add(body)._on_trigger_enter.add(callback)

static func on_trigger_exit(body, callback):
	get_or_add(body)._on_trigger_exit.add(callback)
