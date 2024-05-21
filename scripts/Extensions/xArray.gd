class_name xArray

static func indices(array, predicate):
	var result = []
	for i in range(array.size()):
		if(predicate.call(array[i])):
			result.push_back(i)
	return result

static func foreach(array, action):
	for i in range(array.size()):
		action.call(array[i], i)

static func fromfun(count, fun):
	var result = []
	for i in range(count):
		result.push_back(fun.call(i))
	return result

static func shuffle(array):
	for i in range(array.size()):
		swap(array, i, randi_range(0, array.size()-1))

static func swap(array, i, j):
	var aux = array[i]
	array[i] = array[j]
	array[j] = aux
	
static func pipe(callbacks, initial_value):
	var result = initial_value
	for x in callbacks:
		result = x.call(result)
	return result

static func weights(values, total):
	return values.map(func(x): return x / total)

static func sum(values): #WORKS WITH SCALARS AND VECTORS
	return values.reduce(func(total, value): return total + value)

static func mean(values): #WORKS WITH SCALARS AND VECTORS
	return sum(values) / values.size()

static func contains(a, b): #array a contains b
	return b.all(func(x): return x in a)
