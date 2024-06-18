extends Node2D

var current_castles
var map_scene = load("res://Scenes/Menu/menuCarga.tscn")
var menu_scene = load("res://Scenes/Menu/menuPrincipal.tscn")

func _ready():
	$BlurredBackground.size = get_viewport_rect().size
	current_castles = Save.LoadCurrentCastles()
	current_castles += 1
	Save.SaveCurrentCastles(current_castles)
	Save.SaveIngame(true)
	var max_castles = Save.LoadMaxCastles()
	if current_castles > max_castles:
		Save.SaveMaxCastles(current_castles)

func _on_continuar_pressed():
	Save.SaveIngame(false)
	get_tree().change_scene_to_packed(map_scene)

func _on_salir_pressed():
	get_tree().change_scene_to_packed(menu_scene)
