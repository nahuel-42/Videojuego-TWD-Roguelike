extends Control
var dir_main_menu=load("res://Scenes/Menu/menuPrincipal.tscn")

@export var SignPosition : Vector2 = Vector2(320, 141)
@export var SignColor : Color = Color.WHITE

func _ready():
	get_tree().paused=true
	create_tween().tween_property($Sign, "position", SignPosition, 1)
	create_tween().tween_property($Background, "modulate", SignColor, 1)
	
#func _on_button_button_down():
#	get_tree().paused=false
#	get_tree().change_scene_to_packed(dir_main_menu)


#func _on_main_Resurrect():
#	get_tree().paused=false
#	GameController.Resurrect()
#	GameEvents.OnSetVisible.Call([true])
#	queue_free()


func _on_main_menu_2_pressed():
	pass # Replace with function body.


func _on_main_menu_pressed():
	pass # Replace with function body.
