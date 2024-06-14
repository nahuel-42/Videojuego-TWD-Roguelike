extends Container


var scene_map = load("res://Scenes/Menu/menuCarga.tscn")
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")


func _ready():
	var continuarPartida= $TextureRect/VBoxContainer/ScrollContainer/BoxContainer/MarginContainer/HBoxContainer/HBoxContainer8
	continuarPartida.visible= CardsManager.checkSaveGame()
		
		

func _on_touch_screen_button_pressed():
	if (CardsManager.CheckDeckTypeSelected()):
		get_tree().change_scene_to_packed(scene_map)


func _on_boton_atras_pressed():
	get_tree().change_scene_to_packed(scene_principal)
