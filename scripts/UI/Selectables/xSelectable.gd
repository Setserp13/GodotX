class_name xSelectable

# Define extension methods for Selectable
static func enable(selectable):
	#selectable.enabled = true
	selectable.state = Selectable.State.NORMAL
	if selectable.on_enable:
		selectable.on_enable.invoke()

static func disable(selectable):
	#selectable.enabled = false
	selectable.selected = false
	selectable.state = Selectable.State.DISABLED
	if selectable.on_disable:
		selectable.on_disable.invoke()

static func select(selectable):
	selectable.selected = true
	selectable.state = Selectable.State.SELECTED
	if selectable.on_select:
		selectable.on_select.invoke()

static func deselect(selectable):
	selectable.selected = false
	selectable.selection_state = Selectable.State.NORMAL
	if selectable.on_deselect:
		selectable.on_deselect.invoke()



# Define extension methods for Components
static func enable_component(component):
	if not component:
		return
	var selectable = component.get_node("Selectable")
	if selectable:
		enable(selectable)

static func disable_component(component):
	if not component:
		return
	var selectable = component.get_node("Selectable")
	if selectable:
		disable(selectable)

static func select_component(component):
	if not component:
		return
	var selectable = component.get_node("Selectable")
	if selectable:
		select(selectable)

static func deselect_component(component):
	if not component:
		return
	var selectable = component.get_node("Selectable")
	if selectable:
		deselect(selectable)



# Define method to select only a specific index in a list of Components
static func select_only(components, index):
	for i in range(components.size()):
		var component = components[i]
		if i == index:
			select_component(component)
		else:
			deselect_component(component)
