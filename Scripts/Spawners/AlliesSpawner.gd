extends Spawner

# TODO: Ver si esto queda fijo en 10 aliados por spawner reconstruido o qué
var allies_count : int = 10
const ALLY_PREFAB : String = "res://Prefabs/Ally.tscn"

func _ready():
	characters_node.queue_free()
	
	var new_characters_node = Node2D.new()
	new_characters_node.name = "Allies"
	add_child(new_characters_node)
	
	characters_node = new_characters_node
	
	WaveManager.connect("enable_boss", enable_spawner)
	
	super()
	
func enable_spawner():
	start_next_wave(allies_count)
	
func instantiate_character():
	return load(ALLY_PREFAB).instantiate()
	
func _on_timer_timeout():
	super()
	if last_character_index >= len(characters):
		for character in characters:
			if character.get_process_mode() != Node.ProcessMode.PROCESS_MODE_DISABLED:
				return
		remove_disabled_characters()
