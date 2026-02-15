class_name Behavior

class BehaviorItem:

	var update = Event1.new()
	var start = Event0.new()
	var end = Event0.new()

	func _init():
		pass

	func on_update(value):
		update.add(value)
		return self

	func on_start(value):
		start.add(value)
		return self

	func on_end(value):
		end.add(value)
		return self

var current #key
var items

func _init(initial_val=0):
	self.items = {}
	self.current = Value.new(initial_val)
	self.current.on_change.add(
		func(old, new):
			if old != new:
				if old > -1:
					items[old].end.invoke() #first ends one, only then starts the other
				if new > -1:
					items[new].start.invoke()
	)

func add(key): #add a new BehaviourItem and return it
	if not items.has(key):
		items[key] = BehaviorItem.new()
	return items[key]

func update(delta):
	if current.value > -1:
		items[current.value].update.invoke(delta)
