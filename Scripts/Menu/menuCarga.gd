extends Control


var progress : Array
var scene_load_status : int

func _ready():
	get_tree().paused = false
	scene_load_status = ResourceLoader.load_threaded_request("res://Scenes/mapa.tscn")
	
func _process(delta):
	scene_load_status=ResourceLoader.load_threaded_get_status("res://Scenes/mapa.tscn",progress)
	$TextureProgress.value+= delta*95

func _on_texture_progress_value_changed(value):
	if value == 100 and scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().call_deferred("change_scene_to_packed", ResourceLoader.load_threaded_get("res://Scenes/mapa.tscn"))


