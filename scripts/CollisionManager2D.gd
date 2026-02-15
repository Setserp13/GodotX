extends Node #EventNode

class_name CollisionManager2D #manage all collisions and triggers of an object

@export var collision = true
@export var trigger = true
var _on_collision_enter = Event1.new()
var _on_collision_exit = Event1.new()
var _on_collision_stay = Event1.new()
var _collisions = []
var _on_trigger_enter = Event1.new()
var _on_trigger_exit = Event1.new()
var _on_trigger_stay = Event1.new()
var _triggers = []
var _body

func _ready():
	if _body == null:
		_body = get_parent()

func _process(delta):
	if collision:
		process_collisions()
	if trigger:
		process_triggers()


func process_collisions():
	var collisions = x2D.get_collisions(_body)
	#print(collisions)
	process(_collisions.filter(func(x): return not collisions.any(func(y): return x.get_collider() == y.get_collider())), _on_collision_exit, 'on_collision_exit')
	process(collisions.filter(func(x): return not _collisions.any(func(y): return x.get_collider() == y.get_collider())), _on_collision_enter, 'on_collision_enter')
	process(collisions, _on_collision_stay, 'on_collision_stay')
	_collisions = collisions

func process_triggers():
	var triggers = x2D.get_intersecting_areas(xNode.get_component(_body, CollisionShape2D))
	#print(triggers)
	process(_triggers.filter(func(x): return x not in triggers), _on_trigger_exit, 'on_trigger_exit')
	process(triggers.filter(func(x): return x not in _triggers), _on_trigger_enter, 'on_trigger_enter')
	process(triggers, _on_trigger_stay, 'on_trigger_stay')
	_triggers = triggers



func process(colliders, inner_call, outer_call):
	for x in colliders:
		if x != null:
			inner_call.invoke(x)
		if x != null:
			if x is KinematicCollision2D:
				xObject.try_call(x.get_collider(), outer_call, [_body])
			else:
				xObject.try_call(x, outer_call, [_body])



static func get_or_add(body): #if body already have one, just returns it
	return xNode.get_or_add_component(body, CollisionManager2D)#, {'_body': body})

static func on_collision_enter(body, callback):
	get_or_add(body)._on_collision_enter.add(callback)

static func on_collision_exit(body, callback):
	get_or_add(body)._on_collision_exit.add(callback)

static func on_collision_stay(body, callback):
	get_or_add(body)._on_collision_stay.add(callback)

static func on_trigger_enter(body, callback):
	get_or_add(body)._on_trigger_enter.add(callback)

static func on_trigger_exit(body, callback):
	get_or_add(body)._on_trigger_exit.add(callback)

static func on_trigger_stay(body, callback):
	get_or_add(body)._on_trigger_stay.add(callback)
