extends Control


var escena_mazos = load("res://Scenes/Menu/menuMazos.tscn")
var escena_tienda = load("res://Scenes/Menu/menuTienda.tscn")

func _on_boton_jugar_pressed():
	get_tree().change_scene_to_packed(escena_mazos)


func _on_boton_tienda_pressed():
	get_tree().change_scene_to_packed(escena_tienda)
