class_name FuncObjects

static func OverwriteText(text, stop, char_time):
	return LerpVariant.new(func(x): pass, 0.0, 1.0, char_time * stop.size()).on_update(
		func(t):
			text.text = stop.get_slice(0, int(t * stop.size()))
	)
