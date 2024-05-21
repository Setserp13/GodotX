class_name Config

static var file_path = 'user://config.cfg'
var file
static var _instance = null

func _init():
	file = ConfigFile.new()
	if ResourceLoader.exists(file_path):
		file.load(file_path)

static func get_value(player, key, value):
	return _instance.file.get_value(player, key)

static func set_value(player, key, value):
	_instance.file.set_value(player, key, value)
	_instance.file.save(file_path)

static func get_instance():
	if _instance == null:
		_instance = Config.new()
	return _instance
