class_name Value

var on_change = Event2.new()
var value:
	get:
		return value
	set(new_value):
		on_change.invoke(value, new_value) #old, new
		value = new_value

func _init(value):
	self.value = value
