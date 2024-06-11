extends Node

@export var m_sprite2D : Sprite2D = null
@export var padre : Node2D = null

func _ready():
	m_sprite2D = $Sprite2D
	
func glow_slot():
	padre.glow_slot(m_sprite2D)
	

func unglow_slot():
	padre.unglow_slot(m_sprite2D)

func apply_card(dictionary):
	return padre.apply_card(GlobalCardsList.find_card(dictionary))

func apply_speciality(type : int):
	return padre.apply_speciality(type)
