extends Node2D
@export var m_self : Node2D = null

func _on_button_button_down():
	var dir_main_menu=load("res://Scenes/Menu/menuPrincipal.tscn")
	get_node("/root").free()
	get_node("/root").add_child(dir_main_menu)
	#get_tree().paused=false
	#get_tree().change_scene_to_packed(dir_main_menu)

