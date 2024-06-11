extends Control

var dir_main_menu=load("res://Scenes/Menu/menuPrincipal.tscn")

func _on_button_button_down():
	get_tree().change_scene_to_packed(dir_main_menu) 
