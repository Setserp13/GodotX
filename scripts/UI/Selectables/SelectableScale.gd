extends Node #attach as a Selectable child

class_name SelectableScale

# Scale variables
@export var scales = [
	1.0,  # disabled
	1.1, # highlighted
	1.0, # normal
	1.2, # pressed
	1.15 # selected
]
var _tween
var base_scale
@export var start_state = Selectable.State.NORMAL
@export var trans_duration = .1

func _ready():
	get_parent().state = start_state
	base_scale = get_parent().scale
	get_parent()._state.on_change.add(
		func(old, new):
			#if old != new:
				if _tween != null and _tween.is_running():
					_tween.kill()
				_tween = xTween.do_property(get_parent(), "scale", base_scale * scales[new], trans_duration)
	)
	get_parent().scale = base_scale * scales[get_parent().state]
