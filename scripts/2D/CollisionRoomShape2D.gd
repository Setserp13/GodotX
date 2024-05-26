@tool
extends Node

class_name CollisionRoomShape2D

@export var size = Vector2.ONE * 1000
@export var thickness = 100:
	get: return thickness
	set(value):
		thickness = value
		update()

func _process(delta):
	if not Engine.is_editor_hint():
		return
	
	var prefab = CollisionShape2D.new()
	xNode.resize(self, 4, prefab)
	for x in get_children():
		x.shape = RectangleShape2D.new()
	update()

func update():
	get_child(0).shape.size = Vector2(thickness, size.y)
	get_child(0).position = Vector2.RIGHT * size.x * 0.5
	
	get_child(1).shape.size = Vector2(thickness, size.y)
	get_child(1).position = Vector2.LEFT * size.x * 0.5
	
	get_child(2).shape.size = Vector2(size.x, thickness)
	get_child(2).position = Vector2.UP * size.y * 0.5
	
	get_child(3).shape.size = Vector2(size.x, thickness)
	get_child(3).position = Vector2.DOWN * size.y * 0.5
