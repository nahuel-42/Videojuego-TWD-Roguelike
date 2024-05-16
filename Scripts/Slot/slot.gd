class_name Slot
extends Node2D

@onready var child = null
@onready var speciality = null
var tower_point

const DAMAGE_DECORATOR = "res://prefabs/damage_decorator.tscn"
@export var m_sprite2D : Sprite2D = null

func glow_slot():
	m_sprite2D.flip_v = false

func unglow_slot():
	m_sprite2D.flip_v = true
	
func apply_card(card):
	pass
