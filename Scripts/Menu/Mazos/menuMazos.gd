extends Container

var scene_map = load("res://Scenes/Menu/menuCarga.tscn")
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")

func _on_touch_screen_button_pressed():
	var container = $TextureRect/VBoxContainer/ScrollContainer
	var type = container.get_selected_deck_type()
	if type == CardsManager.DeckType.BLOCKED:
		return
	CardsManager.SetDeckType(type)
	get_tree().change_scene_to_packed(scene_map)

func _on_boton_atras_pressed():
	get_tree().change_scene_to_packed(scene_principal)
