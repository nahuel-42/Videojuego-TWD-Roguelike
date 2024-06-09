class_name Slot
extends Node2D

@onready var child = null
@onready var speciality = null
var tower_point

const DAMAGE_DECORATOR = "res://prefabs/damage_decorator.tscn"
@export var m_sprite2D : Sprite2D = null

func glow_slot():
	m_sprite2D.modulate = Color(128, 128, 128)

func unglow_slot():
	m_sprite2D.modulate = Color(1, 1, 1)
	
func apply_card(card):
	pass
