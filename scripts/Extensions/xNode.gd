class_name xNode

static func get_component(node, type): #a component is a child node or itself
	for x in [node] + node.get_children():
		if is_instance_of(x, type):
			return x
	return null

static func ancestors(node):
	var result = []
	if node.get_parent() != null:
		result.append(node.get_parent())
		result.append_array(ancestors(node.get_parent))
	return result

static func descendants(node):
	var result = []
	for x in node.get_children():
		result.append_array(descendants(x))
	return result
	
static func append_child(node, child): #use this to add a Node via @tool
	node.add_child(child)
	if node.owner == null:
		child.owner = node
	else:
		child.owner = node.owner
	#print(node)
	#print(child.owner)
	child.name = child.name.replace('@', '') #The @ prefix on node names in Godot denotes editor-only nodes.
	return child

static func chain(nodes):
	for i in range(nodes.size()-1):
		append_child(nodes[i], nodes[i+1])

static func get_last_child(node):
	return node.get_child(node.get_children().size()-1)

static func destroy(node):
	var parent = node.get_parent()
	if parent != null:
		parent.remove_child(node)
	node.queue_free()

static func clear(node): #destroy all children
	for x in node.get_children():
		destroy(x)
		

static func resize(parent, new_size, prefab):
	var old_size = parent.get_children().size()
	for i in range(old_size, new_size):
		append_child(parent, prefab.duplicate(true))
	for i in range(new_size, old_size):
		destroy(get_last_child(parent))

static func create_node(type, properties={}):
	var result = type.new()
	for k in properties:
		result[k] = properties[k]
	return result
	
static func create_child(parent, type, properties={}):
	return append_child(parent, create_node(type, properties))

static func set_parent(node, value, keep_global_position=true):
	var global_position = node.global_position
	var parent = node.get_parent()
	if parent != null:
		parent.remove_child(node)
	if value != null:
		value.add_child(node)
	if keep_global_position:
		node.global_position = global_position
