extends AudioStreamPlayer2D

class_name FootstepSoundEffect

@export var multiplier = 0.5
var observer = ChangeObserver.new(func(): return global_position)

func _ready():
	volume_db = Config.get_value('Player', 'Master Volume', 0)

func _process(delta):
	var speed = observer.value.length()
	if speed > 0:
		var pitch = speed * multiplier
		#print(pitch)
		pitch_scale = pitch + 0.1 #cuz pitch cannot be lesser than 0.1
		if not playing:
			play()
	else:
		if playing:
			stop()
	
