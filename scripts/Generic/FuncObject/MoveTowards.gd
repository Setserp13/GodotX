extends FuncObject

class_name MoveTowards

var node
var property
var current:
	get: return xObject.get_property(self.node, self.property)
#var target
var speed
var get_target
var finished = false
var on_update = Event1.new()

func _init(node, property, target, speed : float):
	self.node = node
	self.property = property
	if target is Node:
		self.get_target = func(): return xObject.get_property(target, self.property)#target.global_position
	else:
		self.get_target = func(): return target
	self.speed = speed

func has_finished() -> bool:
	var target = get_target.call()
	var result = xMath.isclose(current, target)
	# Trigger on_end only when result becomes true *this frame*
	if result and not finished:
		finished = true	#important keep it at first
		on_end.invoke()
	elif not result:
		finished = false
	return result

func invoke(delta):
	on_update.invoke(delta)
	#node.global_position = node.global_position.move_toward(get_target.call(), speed * delta)
	#node.global_position = xMath.ease_toward(node.global_position, get_target.call(), speed * delta, 1.0)
	xObject.set_property(node, self.property, xMath.ease_toward(current, get_target.call(), speed * delta, 1.0))
	return has_finished()



