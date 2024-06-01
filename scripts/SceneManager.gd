class_name SceneManager

static func change_scene(tree, next):
	var root = tree.root
	var current = root.get_child(0)
	root.remove_child(current)
	current.queue_free()
	root.add_child(next)
