class_name Slot
extends Node2D

var child
var tower_point

const DAMAGE_DECORATOR = "res://prefabs/damage_decorator.tscn"
@export var m_sprite2D : Sprite2D = null

func glow_slot():
	m_sprite2D.flip_v = false

func unglow_slot():
	m_sprite2D.flip_v = true
	
func apply_card(card):
	pass

# Función provisional para probar interacción con slots. Mergear con grupo de mazos y UI
func _on_click(viewport, event, shape_idx):
	var card = {}
	if event is InputEventMouseButton and event.pressed:
		card["type"] = "upgrade" if child != null else "tower"
		card["id"] = 0 if event.button_index == MOUSE_BUTTON_LEFT else 1
		apply_card(card)
