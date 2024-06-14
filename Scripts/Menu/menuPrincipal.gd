extends Control


var escena_mazos = load("res://Scenes/Menu/menuMazos.tscn")
var escena_tienda = load("res://Scenes/Menu/menuTienda.tscn")
var escena_inventario = load("res://Scenes/Menu/menuInventario.tscn")

func _ready():	
	CardsManager.InitUserSave()

func _on_boton_jugar_pressed():
	get_tree().change_scene_to_packed(escena_mazos)


func _on_boton_tienda_pressed():
	get_tree().change_scene_to_packed(escena_tienda)
	
func _on_boton_inventario_pressed():
	get_tree().change_scene_to_packed(escena_inventario)
