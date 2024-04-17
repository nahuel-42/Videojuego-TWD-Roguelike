extends Node

@export var m_top : Panel = null
@export var m_bottom : Panel = null
@export var m_ID : int = 0

var e_inputEvent = null

var m_side : bool = true

func _ready():
	SetSide(false)

func SetInputEvent(inputEvent):
	e_inputEvent = inputEvent
	

func _on_panel_gui_input(event):
	if (e_inputEvent != null):
		e_inputEvent.call(self, event)

func SetSide(side : bool):
	m_side = side
	
	m_top.set_visible(side)
	m_bottom.set_visible(!side)
