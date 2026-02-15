extends Node

class_name Selectable

enum State { DISABLED, HIGHLIGHTED, NORMAL, PRESSED, SELECTED }

@onready var _index = 0
var index:
	get: return _index
var _state = Value.new(State.NORMAL) #SelectionState
var state:
	get: return _state.value
	set(value):
		if _state.value != value:
			var old = _state.value
			#xArray.remove(_groups[_state.value], index)
			_state.value = value
			_groups[_state.value].append(index)
			on_state_change(old, value) #KEEP IT AT END TO ENABLE FORCE state.value ON on_state_change


#a class that creates and destroys objects of a given kind, and stores all of them
#put that logic at a separated classe before, called SelectableMonitoring, and update it by _state.on_change
#and you can pass that object to global and you clean that class
static var _all = []
static var all:
	get: return _all
static var _groups = [[],[],[],[],[]] #partitions
static var groups:
	get: return _groups




var selected = false

func is_normal(): return state == State.NORMAL

func is_highlighted(): return state == State.HIGHLIGHTED

func is_pressed(): return state == State.PRESSED

func is_selected(): return state == State.SELECTED

func is_disabled(): return state == State.DISABLED

"""var on_pointer_enter = Event0.new()
var on_pointer_exit = Event0.new()
var on_pointer_down = Event0.new()
var on_pointer_up = Event0.new()
var on_pointer_click = Event0.new()"""
var on_enable = Event0.new()
var on_disable = Event0.new()
var on_select = Event0.new()
var on_deselect = Event0.new()
var on_highlight = Event0.new()

func on_cursor_exit(source):
	if state == State.HIGHLIGHTED:
		state = State.NORMAL

func on_cursor_enter(source):
	if state == State.NORMAL:
		state = State.HIGHLIGHTED

func on_cursor_down(source):
	if state == State.HIGHLIGHTED:
		state = State.PRESSED

func on_cursor_up(source):
	if state == State.PRESSED:
		state = State.SELECTED

func on_state_change(old_state, new_state):
	#old_state != new_state
	match old_state:
		State.DISABLED: on_enable.invoke()
		State.SELECTED: on_deselect.invoke()
		_: pass
	match new_state:
		State.DISABLED: on_disable.invoke()
		State.SELECTED: on_select.invoke()
		State.HIGHLIGHTED: on_highlight.invoke()
		_: pass

func disable(): state = State.DISABLED

func enable(): state = State.NORMAL

func select(): state = State.SELECTED

func deselect(): state = State.NORMAL
