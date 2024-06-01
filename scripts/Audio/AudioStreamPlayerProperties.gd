extends Node

class_name AudioStreamPlayerProperties

@export var tags = ['Master', 'Music']
@export var loop = true

static var all = []

func _ready():
	all.append(self)
	call_deferred('init')

func init():
	var volumes = tags.map(func(x): return Config.get_value('Player', x + ' Volume', 0))
	get_parent().volume_db = volumes.reduce(func(total, x): return min(total, x))
	if not get_parent().playing:
		get_parent().play()

func _process(delta):
	if not loop:
		return
	if not get_parent().playing:
		get_parent().play()
