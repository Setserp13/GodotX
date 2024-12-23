extends Control

class_name Menu

func _ready():
	var buttons = get_child(0).get_children()
	var windows = get_child(1).get_children()
	for i in range(buttons.size()):
		init(buttons[i], windows[i])

static func init(button, window):
	print(window)
	#window.get_parent().visible = false
	window.visible = false
	window.scale.y = 0
	button.pressed.connect(func():
		#window.get_parent().visible = true
		window.visible = true
		xTween.do_property(window, 'scale:y', 1, .1)
		)
	window.pressed.connect(func():
		xTween.do_property(window, 'scale:y', 0, .1).tween_callback(func():
			#window.get_parent().visible = false
			window.visible = false
			)
		)
