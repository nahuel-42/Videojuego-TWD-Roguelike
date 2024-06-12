class_name SpawnerDetector
extends Node

@export var m_parent : Node
@export var m_sprite : Sprite2D = null

func glow_slot():
	m_sprite = $Sprite2D
	m_sprite.modulate = Color(255,255,34)
	
func unglow_slot():
	m_sprite = $Sprite2D
	m_sprite.modulate = Color(1, 1, 1)
	
func GetSpawner():
	return m_parent
