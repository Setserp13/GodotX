class_name Config

static var instance:
	get:
		if instance == null:
			instance = Config.new()
		return instance

static var file_path = 'user://config.cfg'#'res://config.cfg'

var _file

func _init():
	self._file = ConfigFile.new()
	var err = self._file.load(file_path)
	# If the file didn't load, ignore it.
	if err != OK:
		return

static func set_value(section, key, value):
	instance._file.set_value(section, key, value)

static func get_value(section, key, default=null):
	return instance._file.get_value(section, key, default)

static func save():
	print(file_path)
	instance._file.save(file_path)
