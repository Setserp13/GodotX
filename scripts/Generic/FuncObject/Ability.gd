extends FuncObject

class_name Ability

var dict = {}

func _init(dict=null):
	if dict != null:
		self.dict = dict

func invoke(delta):
	return true
