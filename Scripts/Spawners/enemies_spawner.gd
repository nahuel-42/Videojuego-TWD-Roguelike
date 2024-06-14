class_name EnemiesSpawner
extends Spawner

signal stage_completed
var ENEMY_TYPES
var stage_completed_flag = false
const ALLIES_SPAWNER_PREFAB :  String = "res://Prefabs/Spawners/AlliesSpawner.tscn"

func register_spawner():
	WaveManager.register_spawner(self)

func _ready():
	characters_node = $Enemies
	WaveManager.connect("activate_spawner", register_spawner)
	super()

func start_next_wave(count):
	super(count)
	stage_completed_flag = false

func instantiate_character():
	var random_value = randi() % 100
	for enemy_type in ENEMY_TYPES:
		if random_value >= enemy_type["first_percent"] and random_value <= enemy_type["last_percent"]:
			var prefab = load(enemy_type["prefab"])
			return prefab.instantiate()
	return null

func _on_timer_timeout():
	super()
	if last_character_index >= len(characters):
		for character in characters:
			if character.get_process_mode() != Node.ProcessMode.PROCESS_MODE_DISABLED:
				return
		remove_disabled_characters()
		stage_completed_flag = true
		emit_signal("stage_completed")

func is_stage_completed():
	return stage_completed_flag
		
func demolish():
	stop()
	var allies_spawner = load(ALLIES_SPAWNER_PREFAB).instantiate()
	get_parent().add_child(allies_spawner)
	allies_spawner.global_position = self.global_position
	queue_free()
	
