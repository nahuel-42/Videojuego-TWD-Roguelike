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

# Función provisional para probar interacción con slots. Mergear con grupo de mazos y UI
func _on_click(viewport, event, shape_idx):
	var card = {}
	if event is InputEventMouseButton and event.pressed:
		card["type"] = "upgrade" if child != null else "tower"
		card["id"] = "t1" if event.button_index == MOUSE_BUTTON_LEFT else "t2"
		apply_card(card)
