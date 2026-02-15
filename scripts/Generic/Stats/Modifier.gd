class_name Modifier

var order = 0
var stats = ObservableCollection.new()
var on_modify = func (x): return x
var on_revert = func (x): return x
var on_change = Event2.new()

func _init(on_modify=null, order=0):
	if on_modify != null:
		self.on_modify = on_modify
	order = order

func modify(value):
	return on_modify.call(value)

func revert(value):
	return on_revert.call(value)

func recalculate():
	for x in stats.items:
		x.recalculate()
