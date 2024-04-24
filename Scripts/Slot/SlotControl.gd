extends Node

@export var m_sprite2D : Sprite2D = null
	
func glow_slot():
	m_sprite2D.flip_v = false

func unglow_slot():
	m_sprite2D.flip_v = true

func apply_card(dictionary):
	print(dictionary)
