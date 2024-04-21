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

# Propiedades de Card de tipo tower: type, prefab_path
const TOWER1_PREFAB_PATH = "res://prefabs/archer_tower.tscn"
const TOWER2_PREFAB_PATH = "res://prefabs/area_tower.tscn"
# Función provisional para probar interacción con slots. Mergear con grupo de mazos y UI
func _on_click(viewport, event, shape_idx):
	var card = {}
	if event is InputEventMouseButton and event.pressed:
		card["type"] = "upgrade" if child != null else "tower"
		card["prefab_path"] = TOWER1_PREFAB_PATH if event.button_index == MOUSE_BUTTON_LEFT else TOWER2_PREFAB_PATH
		apply_card(card)
