class_name ObservableCollection

var items = []
var on_change = Event2.new() #(list of removed elements, list of added elements)

func _init(items=null):
	self.items = [] if items == null else items
	
func add(item):
	items.append(item)
	on_change.invoke([], [item])

func insert(index, item):
	items.insert(index, item)
	on_change.invoke([], [item])

func remove_at(index):
	on_change.invoke([items.pop_at(index)], [])

func remove(item):
	var index = items.find(item)
	if index > -1:
		remove_at(index)

func clear():
	var old = items.duplicate(false)
	items.clear()
	on_change.invoke(old, [])
