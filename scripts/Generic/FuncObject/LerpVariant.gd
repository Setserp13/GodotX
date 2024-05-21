extends LerpValue

class_name LerpVariant

func _init(setter, start, stop, step):
	super(func(a, b, t): return lerp(a, b, t), setter, start, stop, step)
