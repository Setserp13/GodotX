extends Tweening

class_name LerpValue

var lerp #lerp(a,b,t) -> c
var inverse_lerp #lerp(a,b,c) -> t
var to_duration #to_duration(start, stop, speed) -> duration
var setter
var start #start value
var stop #end value
var step #speed
var duration:
	get:
		return xMath.invert(step)
var ease

func _init(lerp, setter, start, stop, step : float):
	self.lerp = lerp
	self.setter = setter
	self.start = start
	self.stop = stop
	set_duration(step) #set duration based step #self.step = step
	self.ease = ease
	self.ease=func(x): return ease(x, -2)
	self.t = 0.0

func set_t(value):
	t = value
	return self

func set_ease(curve):
	ease = func(t): return ease(t, curve)
	return self

func set_duration(value):
	step = xMath.invert(value)
	return self

func has_finished():
	return t >= 1.0

func invoke(delta):
	t = clamp(t + delta * step, 0.0, 1.0)
	setter.call(lerp.call(start, stop, ease.call(t)))
	update.invoke(t)
	return has_finished()

func set_speed_based(value):
	if value:
		set_speed(step)
	return self

func set_speed(value : float):
	set_duration(to_duration.call(start, stop, duration))
	return self

func start_from(value):
	t = ease.time_of(inverse_lerp.call(start, stop, value))
	return self
