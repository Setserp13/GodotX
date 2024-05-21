extends Group

class_name Parallel

func invoke(delta):
	t = items.map(func(x): return x.t).max()
	update.invoke(t)
	finished = true
	for x in items:
		var result = x.has_finished()
		if not result:
			x.invoke(delta)
		finished = finished and result
	if finished:
		if loops > 0:
			if loops < INF:
				loops -= 1
			reset()
			finished = false
	return has_finished()
