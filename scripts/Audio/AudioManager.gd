extends Node

class_name AudioManager

static var instance = null
""":
	get:
			instance = AudioManager.new()
			instance.init()
		return instance"""

var _pool
var _items = [] #a list of objects like (AudioStreamPlayer, loop)
var _library = {}
const sounds_dir = 'res://Sounds/'

#PUT THE FUNC BELOW IN A STATIC CLASS LATER
static func read_json(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	#file.close()
	#print(content)
	var json = JSON.new()
	var error = json.parse(content)
	if error == OK:
		return json.data

func _ready():
	instance = self
	#print(instance)
	init()

func init():
	_library = read_json(sounds_dir + 'sounds_lib.json')
	for k in _library:
		_library[k] = load(sounds_dir + _library[k])
	_pool = ObjectPool.new(AudioStreamPlayer.new(), self)

func _process(delta):
	for i in range(_items.size()-1,-1,-1):
		if not _items[i]['audio'].playing:
			if _items[i]['loop'] > 0:
				_items[i]['loop'] -= 1
				_items[i]['audio'].play()
			else:
				_pool.release(_items.pop_at(i)['audio'])

static func play(audio_name, loop=0, tag='Master'):
	#print(instance)
	#print(instance._library)
	var audio = instance._library[audio_name]
	var player = instance._pool.pick()
	player.stream = audio
	player.volume_db = Config.get_value('Player', tag + ' Volume', 0)
	player.play()
	instance._items.append({'audio': player, 'loop': loop, 'tag': tag})
