extends Control

class_name Dialog

#first child is the cancel button, and the second is the accept button, you can make a dialog with more than two buttons too
var _prev_scale
var on_pressed = []

func _ready():
	_prev_scale = scale
	scale = Vector2.ZERO
	for i in range(get_child_count()):
		var event = Event0.new()
		on_pressed.append(event)
		get_child(i).pressed.connect(
			func():
				event.invoke()
				open(false)
		)

func open(value=true): #overwrite it in derived classes
	xTween.do_property(self, 'scale', _prev_scale if value else Vector2.ZERO, .3)
