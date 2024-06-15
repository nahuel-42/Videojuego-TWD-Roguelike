extends Control
var dir_main_menu=load("res://Scenes/Menu/menuPrincipal.tscn")

@export var SignPosition : Vector2 = Vector2(320, 141)
@export var SignColor : Color = Color.WHITE

func _ready():
	create_tween().tween_property($Sign, "position", SignPosition, 1)
	create_tween().tween_property($Background, "modulate", SignColor, 1)
	
func _on_button_button_down():
	get_tree().change_scene_to_packed(dir_main_menu)
