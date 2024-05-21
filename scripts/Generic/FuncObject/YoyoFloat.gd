extends YoyoValue

class_name YoyoFloat

func _init(setter, start, stop, step):
	var lerp = func(a, b, t): return lerp(a, b, t)
	var inverse_lerp = func(a, b, t): return inverse_lerp(a, b, t)
	var distance = func(a, b, v): return xMath.duration(a, b, v)
	super(lerp, inverse_lerp, distance, setter, start, stop, step)
