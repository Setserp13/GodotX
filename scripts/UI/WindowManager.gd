extends Node

#If button.name == window.name then button opens the window. If button has name "Back" it opens "Menu" 

@export var windows : Array[Control] = []
var current

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = []
	var parent = get_parent()
	for x in xNode.descendants_of_type(parent, Button):
		var name = x.name
		if name == "Back":
			name = "Menu"
		var window = xArray.find(windows, func(x): return x.name == name)
		#print(x.name, window)
		if window == null:
			continue
		x.pressed.connect(func(): open_window(window))
	for x in windows:
		if x.name == "Menu":
			x.scale[0] = 1.0
			current = x
		else:
			x.scale[0] = 0.0
	
func open_window(window):
	var tween = self.create_tween()
	var duration = .25
	if current != null:
		tween.tween_property(current, "scale:x", 0.0, duration)
	tween.parallel().tween_property(window, "scale:x", 1.0, duration)
	current = window

	

