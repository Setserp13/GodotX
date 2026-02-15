extends Value

class_name Stat

var base_value: Value
var modifiers : ObservableCollection

func _init(value):
	super(value)
	base_value = Value.new(value)
	modifiers = ObservableCollection.new([])
	modifiers.on_change.add(func(old, new): recalculate())
	base_value.on_change.add(func(old, new): recalculate())
	recalculate()

func add_modifier(modifier):
	modifiers.add(modifier)
	modifier.stats.add(self)

func remove_modifier(modifier):
	modifiers.remove(modifier)
	modifier.stats.remove(self)

func modify():
	return xArray.pipe(modifiers.items.map(func (x): return x.modify), base_value.value)

func revert():
	return xArray.pipe(modifiers.items.map(func (x): return x.revert), value)

func recalculate():
	value = modify()
