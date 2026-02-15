extends Node

class_name VolumeButton

@export var tag = 'Master'

func _ready():
	call_deferred('init')

func init():
	var volume = Config.get_value('Player', tag + ' Volume', 0)
	get_parent()._current.on_change.add(
		func(old, new):
			var volume_db = [-80, -10, 0][new]
			Config.set_value('Player', tag + ' Volume', volume_db)
			Config.save()
			for x in AudioStreamPlayerProperties.all:
				x.init())
	get_parent().value = {-80:0, -10:1, 0:2}[volume]
