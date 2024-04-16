extends Node

@export var m_ID : int = 0

var e_inputEvent = null

func SetInputEvent(inputEvent):
	e_inputEvent = inputEvent
	
func _on_gui_input(event):
	if (e_inputEvent != null):
		e_inputEvent.call(self, event)
		
