extends Group

class_name Sequence

func invoke(delta):
	t = xArray.sum(items.map(func(x): return x.t))
	update.invoke(t)
	for x in items:
		if not x.has_finished():
			x.invoke(delta)
			finished = false
			return has_finished()
	if loops > 0:
		if loops < INF:
			loops -= 1
		reset()
		finished = false
	else:
		finished = true
	return has_finished()
