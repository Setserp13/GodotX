extends Node #attach as a Selectable child

class_name SelectableColor

# Color variables
@export var colors = [
	Color(0, 0, 0),  # Black # disabled
	Color(1, 1, 1), # White # highlighted
	Color(0, 1, 0), # Green # normal
	Color(1, 1, 0), # Yellow # pressed
	Color(0, 1, 1) # Cyan # selected
]
var _tween
var sprites

var sprites_modulate:
	set(value):
		for x in sprites:
			print(x)
			x.modulate = value
		sprites_modulate = value

func _ready():
	print(xNode.descendants(get_parent()))
	sprites = xNode.descendants(get_parent()).filter(func(x): return is_instance_of(x, Sprite3D))
	sprites_modulate = colors[get_parent().state]
	get_parent()._state.on_change.add(
		func(old, new):
			if old != new:
				if _tween != null and _tween.is_running():
					_tween.kill()
				_tween = xTween.do_property(self, "sprites_modulate", colors[new], .3)
	)
	
