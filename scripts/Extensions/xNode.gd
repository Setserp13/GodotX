class_name xNode

static func descendants_of_type(node, type):
	return descendants(node).filter(func(x): return is_instance_of(x, type))

static func ancestors_of_type(node, type):
	return ancestors(node).filter(func(x): return is_instance_of(x, type))

static func ancestor_of_type(node, type):
	for x in ancestors(node):
		if is_instance_of(x, type):
			return x
	return null


static func get_component(node, type): #a component is a child node or itself
	for x in [node] + descendants(node):#node.get_children():
		if is_instance_of(x, type):
			return x
	return null

static func get_components(node, type):
	return ([node] + descendants(node)).filter(func(x): return is_instance_of(x, type))

static func get_or_add_component(node, type):
	var result = get_component(node, type)
	if result == null:
		result = create_child(node, type)
	return result

"""static func ancestors(node):
	var result = []
	if node.get_parent() != null:
		result.append(node.get_parent())
		result.append_array(ancestors(node.get_parent()))
	return result"""

static func ancestors(node: Node) -> Array[Node]:
	var result: Array[Node] = []
	var current := node.get_parent()
	var scene_owner := node.owner

	while current and current != scene_owner:
		result.append(current)
		current = current.get_parent()

	if scene_owner:
		result.append(scene_owner)

	return result

static func descendants(node):
	var result = []
	for x in node.get_children():
		result.append(x)
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

static func get_or_create_child(parent, name, type, properties={}):
	var result = parent.get_node_or_null(name)
	if result == null:
		result = create_child(parent, type, {'name': name} + properties)
	return result

static func instantiate_child(parent, prefab, editable_children=true):
	var result = prefab.instantiate()
	xNode.append_child(parent, result)
	if editable_children:
		for x in [result] + xNode.descendants(result):
			parent.set_editable_instance(x, true)
	result.name = prefab.get_state().get_node_name(0)
	return result

static func set_parent(node, value, keep_global_position=true):
	var global_position = node.global_position
	var parent = node.get_parent()
	if parent != null:
		parent.remove_child(node)
	if value != null:
		value.add_child(node)
	if keep_global_position:
		node.global_position = global_position

static func children_of_type(node, type):
	return node.get_children().filter(func(x): return is_instance_of(x, type))

static func resize_by_type(node, new_size, type):
	var children = children_of_type(node, type)
	for i in range(children.size(), new_size):
		xNode.create_child(node, type)
	for i in range(children.size()-1, new_size-1, -1):
		xNode.destroy(children[i])
	return children_of_type(node, type)

static func set_pivot(transform, value, normalized=true):
	if normalized:
		value = xRect2.denormalize_point(x2D.aabb(transform), value)
	var delta = value - transform.position
	transform.position = value
	for x in transform.get_children():
		x.position -= delta

static func set_active(node: Node, value: bool, recursive: bool = true, ignore_visibility: bool = false):
	if not node: return
	
	if node is CanvasItem and not ignore_visibility:
		node.visible = value

	#print(node, value)
	node.set_process(value)
	node.set_physics_process(value)
	node.set_process_input(value)
	node.set_process_unhandled_input(value)
	node.set_process_unhandled_key_input(value)
	if recursive:
		for child in node.get_children():
			set_active(child, value, recursive, ignore_visibility)

static func create_parent_pivot(node, pivot, normalized = true):
	if normalized:
		pivot = xRect2.denormalize_point(x2D.aabb(node), pivot)
	var parent = xNode.create_node(Node2D)
	parent.global_position = pivot
	xNode.set_parent(parent, node.get_parent())
	xNode.set_parent(node, parent)
	return parent

static func find_scripts(root, script_name):
	return descendants(root).filter(
		func(x):
			if not x.get_script():
				return false
			return x.get_script().resource_path.get_file().get_basename() == script_name
	)
