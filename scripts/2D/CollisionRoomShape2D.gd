@tool
extends Node

class_name CollisionRoomShape2D

@export var left = true
@export var right = true
@export var down = true
@export var up = true
@export var size = Vector2.ONE * 1000:
	get: return size
	set(value):
		size = value
		update()
@export var thickness = 100:
	get: return thickness
	set(value):
		thickness = value
		update()

func _process(delta):
	if not Engine.is_editor_hint():
		return
	generate_walls()
	update()

func generate_walls():
	var prefab = CollisionShape2D.new()
	xNode.resize(self, 4, prefab)
	for x in get_children():
		x.shape = RectangleShape2D.new()

func update():
	if get_child_count() < 4:
		generate_walls()

	get_child(0).disabled = not right
	get_child(0).shape.size = Vector2(thickness, size.y)
	get_child(0).position = Vector2.RIGHT * (size.x + thickness) * 0.5
	
	get_child(1).disabled = not left
	get_child(1).shape.size = Vector2(thickness, size.y)
	get_child(1).position = Vector2.LEFT * (size.x + thickness) * 0.5
	
	get_child(2).disabled = not up
	get_child(2).shape.size = Vector2(size.x, thickness)
	get_child(2).position = Vector2.UP * (size.y + thickness) * 0.5
	
	get_child(3).disabled = not down
	get_child(3).shape.size = Vector2(size.x, thickness)
	get_child(3).position = Vector2.DOWN * (size.y + thickness) * 0.5
