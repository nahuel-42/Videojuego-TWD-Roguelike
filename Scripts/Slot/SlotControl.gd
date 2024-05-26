extends Node

@export var m_sprite2D : Sprite2D = null
@export var padre : Node2D = null

func _ready():
	m_sprite2D = $Sprite2D
	
func glow_slot():
	m_sprite2D.flip_v = false

func unglow_slot():
	m_sprite2D.flip_v = true

func apply_card(dictionary):
	return padre.apply_card(GlobalCardsList.find_card(dictionary))
