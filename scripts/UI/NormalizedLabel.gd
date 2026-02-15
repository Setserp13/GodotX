@tool
extends Label
@export var normalized_position = Vector2(0.5, 0.5)
@export var normalized_pivot = Vector2(0.5, 0.5)
@export var normalized_size = Vector2.ONE

func _process(delta):
	var control = self if is_instance_of(self, Control) else self.get_parent()
	update(control)

func update(label: Label):
	var font := label.label_settings.font
	var font_size := label.label_settings.font_size
	#print(font_size)
	var text_width := font.get_string_size(label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	var parent_width = label.get_parent().get_global_rect().size.x * normalized_size
	var s = parent_width[0] / text_width
	#print(text_width, parent_width)
	label.scale = Vector2.ONE * s
	var global_position = xRect2.denormalize_point(label.get_parent().get_global_rect(), normalized_position)
	xControl.set_global_position(label, global_position, normalized_pivot)
