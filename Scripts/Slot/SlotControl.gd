extends Node

@export var m_sprite2D : Sprite2D = null
	
func OnSelected():
	m_sprite2D.flip_v = false

func UnSelected():
	m_sprite2D.flip_v = true
