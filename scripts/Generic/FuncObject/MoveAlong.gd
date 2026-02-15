extends FuncObject

class_name MoveAlong

var node
var property
var targets
var speed
var index
var loop
var current:
	get: return xObject.get_property(self.node, self.property)
var on_update = Event1.new()
var finished = false

func _init(node, property, targets, speed : float, loop=true, start_index=0):
	self.node = node
	self.property = property
	self.targets = targets
	self.speed = speed
	self.index = start_index
	self.loop = loop

func has_finished() -> bool:
	var result = index > targets.size() - 1
	# Trigger on_end only when result becomes true *this frame*
	if result and not finished:
		finished = true	#important keep it at first
		on_end.invoke()
	elif not result:
		finished = false
	return result

func invoke(delta):
	on_update.invoke(delta)
	var target = targets[index]
	#print(current, target)
	if xMath.isclose(current, target):
		if loop:
			index = (index + 1) % targets.size()
		else:
			index += 1
	else:
		xObject.set_property(node, property, xMath.ease_toward(current, target, speed * delta))
	return has_finished()
