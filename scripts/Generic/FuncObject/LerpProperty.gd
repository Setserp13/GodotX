extends LerpVariant

class_name LerpProperty

func _init(object, property, start, stop, step):
	super(func(x): object[property]=x, object[property], stop, step)
