class_name SnappingAxes

var _axes

#SET OPERATIONS WITH STRINGS
static func contains(a, b):
	for i in range(b.length()):
		if b[i] not in a:
			return false
	return true

func get_combinations(input_str: String) -> Array:
	var combinations = []
	var n = input_str.length()
	for length in range(1, n + 1):
		combinations += _get_combinations_recursive(input_str, '', length, 0)
	return combinations

func _get_combinations_recursive(input_str: String, current_comb: String, length: int, index: int) -> Array:
	if current_comb.length() == length:
		return [current_comb]
	var result = []
	for i in range(index, input_str.length()):
		result += _get_combinations_recursive(input_str, current_comb + input_str[i], length, i + 1)
	return result

func update_others(k):
	if _axes[k]:
		for l in _axes:
			if k != l and (contains(str(k), l) or contains(l, str(k))):
				_axes[l] = false

func _get(property):
	if property in _axes:
		return _axes[property]

func _set(property, value):
	#print(value)
	if property in _axes:
		_axes[property] = value
		update_others(property)
		return true
	return false

func _init(axes='XY'):
	_axes = {}
	for k in get_combinations(axes):
		_axes[k] = false
	for k in axes:
		_axes[k] = true

func to_indices():
	var result = []
	for k in _axes:
		if _axes[k]:
			result.append(xArray.indices(['X', 'Y', 'Z'], func(x): return x in k))
	return result
