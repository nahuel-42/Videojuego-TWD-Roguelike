class_name EnemiesSpawner
extends Node2D

signal wave_completed

var ENEMY_TYPES
var enemies = []
var enemies_node
var last_enemy_index = 0
var wave_completed_flag = false

func _ready():
	enemies_node = $Enemies
	WaveManager.call_deferred("register_spawner", self)

func start_next_wave(enemy_count):
	load_enemies(enemy_count)
	last_enemy_index = 0
	wave_completed_flag = false
	$Timer.start()

func load_enemies(enemy_count):
	enemies = []
	for i in range(enemy_count):
		var enemy_instance = instantiate_enemy()
		enemies_node.add_child(enemy_instance)
		enemies.append(enemy_instance)
		enemy_instance.set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		enemy_instance.visible = false

func instantiate_enemy():
	var random_value = randi() % 100
	for enemy_type in ENEMY_TYPES:
		if random_value >= enemy_type["first_percent"] and random_value <= enemy_type["last_percent"]:
			var prefab = load(enemy_type["prefab"])
			return prefab.instantiate()
	return null

func _on_timer_timeout():
	if last_enemy_index < len(enemies):
		enemies[last_enemy_index].set_process_mode(Node.ProcessMode.PROCESS_MODE_INHERIT)
		enemies[last_enemy_index].visible = true
		last_enemy_index += 1
	else:
		reset_enemies()

func reset_enemies():
	for enemy in enemies:
		if enemy.get_process_mode() != Node.ProcessMode.PROCESS_MODE_DISABLED:
			return
	print("Wave finalizada")
	wave_completed_flag = true
	emit_signal("wave_completed")

func is_wave_completed():
	return wave_completed_flag
