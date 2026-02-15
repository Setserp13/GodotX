class_name SceneManager

static func change_scene(tree, next):	#next can be a Node, a path or a PackedScene
	if next is String:
		#tree.change_scene_to_file(next)
		next = load(next).instantiate()
	elif next is PackedScene:
		#tree.change_scene_to_packed(next)
		next = next.instantiate()
	var root = tree.root
	var current = root.get_child(0)
	#print(current)
	for x in tree.get_processed_tweens():	#kill all tweens to avoid null exception
		x.kill()
	root.remove_child(current)
	current.queue_free()
	root.add_child(next)

"""@export var scenes: Dictionary = {
	1: "res://scenes/level_1.tscn",
	2: "res://scenes/level_2.tscn",
	"shop": "res://scenes/shop.tscn",
	"boss": "res://scenes/boss_arena.tscn"
}"""
# Call this from anywhere:
# change_scene_to(1, Vector2(200, 100))
# change_scene_to("boss", Vector2(50, 300))
static func change_scene_to(tree, next, player_start_position: Vector2):
	#var scene_path = scenes[scene_id]
	change_scene(tree, next)

	# Find player node inside new scene
	var player = tree.root.get_node_or_null("Player")
	if player:
		player.global_position = player_start_position
	else:
		push_warning("⚠️ Player node not found in new scene: %s" % tree.root)
