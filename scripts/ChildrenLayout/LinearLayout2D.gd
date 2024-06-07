extends PropertyLayout

class_name LinearLayout2D

@export var direction = Vector2.RIGHT #: Variant
@export var offset = 0
@export var cell_size = 1
@export var spacing = 0
	
func get_target(i): return direction * (offset + (cell_size + spacing) * i)
