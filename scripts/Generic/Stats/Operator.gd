extends Modifier

class_name Operator

var stat : Stat

func _init(value, order=0):
	self.order = order#DO NOT USE SUPER
	stat = Stat.new(value)
	stat.on_change.add(func(old, new): recalculate())

static func Add(value, order=0):
	var result = Operator.new(value, order)
	result.on_modify = func(x): return x + result.stat.value
	result.on_revert = func(x): return x - result.stat.value
	return result

static func Mul(value, order=0):
	var result = Operator.new(value, order)
	result.on_modify = func(x): return x * result.stat.value
	result.on_revert = func(x): return x / result.stat.value
	return result

static func Pow(value, order=0):
	var result = Operator.new(value, order)
	result.on_modify = func(x): return x ** result.stat.value
	result.on_revert = func(x): return pow(x, 1.0 / result.stat.value)
	return result
