extends LerpValue

class_name YoyoValue

func _init(lerp, inverse_lerp, to_duration, setter, start, stop, step):
	super(lerp, setter, start, stop, step)
	self.inverse_lerp = inverse_lerp
	self.to_duration = to_duration
	#set_speed(step)

func has_finished():
	return false

func invoke(delta):
	t = t + step * delta
	setter.call(lerp.call(start, stop, ease.call(pingpong(t, 1))))
	return false
