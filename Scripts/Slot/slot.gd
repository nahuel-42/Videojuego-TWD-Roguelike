class_name Slot
extends Node2D

@onready var child = null
@onready var speciality = null
var tower_point

const DAMAGE_DECORATOR = "res://prefabs/damage_decorator.tscn"
@export var m_sprite2D : Sprite2D = null

func glow_slot(sprite):
	sprite.modulate = Color(255,255,34)
	if child != null:
		child.glow()

func unglow_slot(sprite):
	sprite.modulate = Color(1, 1, 1)
	if child != null:
		child.unglow()
	
func apply_card(card):
	pass
	
func check_speciality(card):
	pass
