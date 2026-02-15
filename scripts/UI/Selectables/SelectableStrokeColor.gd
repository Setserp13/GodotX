extends Node #attach as a Selectable child

class_name SelectableStrokeColor

# Color variables
@export var colors = [
	Color(0, 0, 0),  # Black # disabled
	Color(1, 1, 1), # White # highlighted
	Color(0, 1, 0), # Green # normal
	Color(1, 1, 0), # Yellow # pressed
	Color(0, 1, 1) # Cyan # selected
]
var _tween

func _ready():
	get_parent()._state.on_change.add(
		func(old, new):
			if old != new:
				if _tween != null and _tween.is_running():
					_tween.kill()
				_tween = xTween.do_property(self, "modulate", colors[new], .3)
	)
	self.modulate = colors[get_parent().state]
