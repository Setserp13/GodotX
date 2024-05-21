extends Ability

class_name AnonymousAbility

var event = Event1.new()

func _init(action, dict=null):
	super(dict)
	event.add(action)

func invoke(delta):
	return event.invoke(delta)
