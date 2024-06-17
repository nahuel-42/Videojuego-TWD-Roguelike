extends Control
var scene_principal = load("res://Scenes/Menu/menuPrincipal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_touch_screen_button_pressed():
	get_tree().change_scene_to_packed(scene_principal)
	Save.SaveVolume(AudioServer.get_bus_volume_db(0))
