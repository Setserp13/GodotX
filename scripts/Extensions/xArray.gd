class_name xArray

static func get_items(array, indices): return indices.map(func(x): return array[x])

static func get_randoms(array, count):
	var result = range(array.size())
	result.shuffle()
	return get_items(array, result.slice(0, count))

static func indices(array, predicate):
	var result = []
	for i in range(array.size()):
		if(predicate.call(array[i])):
			result.push_back(i)
	return result

static func foreach(array, action, arg_count=2):
	for i in range(array.size()):
			action.call(array[i], i) if arg_count == 2 else action.call(array[i])

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

static func pop_random(array): return array.pop_at(randi_range(0, array.size()-1))

static func pop(array, item): return array.pop_at(array.find(item))

static func remove(array, item): array.remove_at(array.find(item))

static func update(array, mapping, condition):
	for i in range(array.size()):
		if condition.call(array[i], i):
			array[i] = mapping.call(array[i], i)
	return array

static func replace(array, old_value, new_value):
	return update(array, func(x, i): return new_value, func(x, i): return x == old_value)

static func remove_where(array, condition):
	for i in range(array.size()-1, -1, -1):
		if condition.call(array[i], i):
			array.remove_at(i)

static func to_distinct(array):
	var result = []
	for x in array:
		if x not in result:
			result.append(x)
	return result
