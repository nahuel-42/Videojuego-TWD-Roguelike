extends Control

var change_scene = load("res://Scenes/Menu/menuMazos.tscn")

func _on_boton_jugar_pressed():
	get_tree().change_scene_to_packed(change_scene)
