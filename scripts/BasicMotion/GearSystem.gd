extends Node2D
class_name GearSystem

@export var speed: float = 1.0
@export var teeth: Array[int] = []

var _angular_speeds: Array[float] = []

func _ready():
	call_deferred("init")

func init() -> void:
	if teeth == null or teeth.size() < get_child_count():
		var vertices_per_tooth = 4
		for child in get_children():
			teeth.append(int(child.polygon.size() / vertices_per_tooth))
	print(teeth)
	_compute_angular_speeds()

func _process(delta: float) -> void:
	var children := get_children()

	for i in children.size():
		if children[i] is Node2D:
			children[i].rotation += _angular_speeds[i] * delta

func _compute_angular_speeds() -> void:
	var children := get_children()
	var count := min(children.size(), teeth.size())

	_angular_speeds.clear()
	_angular_speeds.resize(count)

	if count == 0:
		return

	# First gear
	_angular_speeds[0] = speed

	# Rest of the train
	for i in range(1, count):
		var ratio := float(teeth[i - 1]) / float(teeth[i])
		_angular_speeds[i] = -_angular_speeds[i - 1] * ratio
