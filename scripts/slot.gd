extends Node2D

var child
var tower_point

const DAMAGE_DECORATOR = "res://prefabs/damage_decorator.tscn"

func glow_slot():
	pass
	
func unglow_slot():
	pass
	
func apply_card(card):
	pass
	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		apply_card(card)
