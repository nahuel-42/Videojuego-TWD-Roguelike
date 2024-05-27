extends Container


var change_scene = load("res://Scenes/Menu/menuCarga.tscn")


func _on_touch_screen_button_pressed():
	get_tree().change_scene_to_packed(change_scene)
