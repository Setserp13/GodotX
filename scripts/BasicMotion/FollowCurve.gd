extends Node2D

@export var curve: Curve2D
@export var curve_owner: Node2D   # Node that defines the transform
@export var speed: float = 10.0
@export var loop: bool = true
@export var ping_pong: bool = true
@export var look_forward: bool = false

# Easing
@export_range(0.1, 5.0) var ease_strength: float = 2.0
@export_enum("Linear", "Ease In", "Ease Out", "Ease In-Out")
var ease_mode: int = 0

var _distance: float = 0.0
var _curve_length: float = 0.0
var _direction: float = 1.0

var _initial_transform

func _ready():
	if curve:
		_curve_length = curve.get_baked_length()
	_initial_transform = global_transform

func _process(delta):
	if not curve or _curve_length == 0:
		return
	
	_distance += speed * delta * _direction
	
	if ping_pong:
		if _distance >= _curve_length:
			_distance = _curve_length
			_direction = -1.0
		elif _distance <= 0.0:
			_distance = 0.0
			_direction = 1.0
	
	elif loop:
		_distance = fmod(_distance, _curve_length)
	
	else:
		_distance = clamp(_distance, 0.0, _curve_length)
	
	var t = _distance / _curve_length
	t = _apply_ease(t)
	
	var eased_distance = t * _curve_length
	
	var local_pos = curve.sample_baked(eased_distance)
	var global_pos = _to_global(local_pos)
	
	global_position = global_pos
	print(local_pos, global_position)
	if look_forward:
		var ahead_local = curve.sample_baked(
			clamp(eased_distance + 5.0 * _direction, 0.0, _curve_length)
		)
		var ahead_global = _to_global(ahead_local)
		rotation = (ahead_global - global_pos).angle()

func _to_global(local_point: Vector2) -> Vector2:
	return _initial_transform * local_point

func _apply_ease(t: float) -> float:
	match ease_mode:
		0:
			return t
		1:
			return pow(t, ease_strength)
		2:
			return 1.0 - pow(1.0 - t, ease_strength)
		3:
			if t < 0.5:
				return pow(t * 2.0, ease_strength) / 2.0
			else:
				return 1.0 - pow((1.0 - t) * 2.0, ease_strength) / 2.0
	return t
