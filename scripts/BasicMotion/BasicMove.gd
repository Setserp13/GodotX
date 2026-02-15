extends Node
class_name BasicMove

enum EndMode {
	CLAMP,
	REPEAT,
	YOYO
}

@export var speed: float = 1.0              # world units per second
@export var end_mode: EndMode = EndMode.CLAMP
@export var ease: Curve                     # optional easing curve
@export var auto_start := true

var _u := 0.0        # traveled units
var _dir := 1.0
var _active := false

func _ready():
	if auto_start:
		start()

func start():
	_u = 0.0
	_dir = 1.0
	_active = true

func stop():
	_active = false

func get_length(): pass
func apply(te): pass

func _process(delta):
	if not _active:
		return

	var length = get_length()
	if length <= 0.0:
		return

	_u += speed * delta * _dir

	var t := clamp(_u / length, 0.0, 1.0)
	var te := apply_ease(t)

	apply(te)

	if _u >= length or _u <= 0.0:
		on_limit(length)

func apply_ease(t: float) -> float:
	if ease:
		return clamp(ease.sample(t), 0.0, 1.0)
	return t


func on_limit(length: float):
	match end_mode:
		EndMode.CLAMP:
			_u = clamp(_u, 0.0, length)
			stop()

		EndMode.REPEAT:
			_u = 0.0

		EndMode.YOYO:
			_dir *= -1


