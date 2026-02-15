class_name xString

static func substrf(text, start, end):
	return text.substr(int(round(text.length() * start)), int(round(text.length() * end)))

static func search(text, pattern):
	var regex = RegEx.new()
	regex.compile("[A-Za-z]")
	return regex.search(text)

static func has(text, pattern): return search(text, pattern) != null
