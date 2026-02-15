extends Button

class_name StateButton

@export var textures = []
var _current = Value.new(0)
var value:
	get: return _current.value
	set(value):
		_current.value = value % textures.size()
		get_child(0).texture = textures[_current.value]

func _ready():
	call_deferred('init')

func init():
	pressed.connect(func(): value += 1)
