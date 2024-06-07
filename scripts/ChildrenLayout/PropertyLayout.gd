@tool
extends SiblingLayout

class_name PropertyLayout

@export var immediate = false
@export var property = 'position'
@export var speed = 100

func update_child(delta, x, i):
	var target = get_target(i)
	if Engine.is_editor_hint() or immediate:
		x.set(property, target)
	else:
		x.set(property, x.get(property).move_toward(target, speed))
	return x.get(property) == target

func get_target(i): return Vector2.ZERO
