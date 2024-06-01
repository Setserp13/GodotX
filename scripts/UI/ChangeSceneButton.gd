extends Button

@export var scene_path = 'res://Scenes/*.tscn'

func _ready():
	var scene = load(scene_path).instantiate()
	pressed.connect(func():
		SceneManager.change_scene(get_tree(), scene))
