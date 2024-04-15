extends Node2D

const ENEMY_PREFAB_PATH = "res://prefabs/Enemy.tscn"

var last_enemy_index
var enemies = []

func _ready():
	last_enemy_index = 0
	load_enemies()

func load_enemies():
	var prefab = load(ENEMY_PREFAB_PATH)
	for i in range(10):  # Agrega 10 enemigos de ejemplo
		var enemy_instance = prefab.instantiate()
		add_child(enemy_instance)
		enemies.append(enemy_instance)
		enemy_instance.set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		enemy_instance.visible = false


func _on_timer_timeout():
	if last_enemy_index < len(enemies):
		enemies[last_enemy_index].set_process_mode(Node.ProcessMode.PROCESS_MODE_INHERIT)
		enemies[last_enemy_index].visible = true
		last_enemy_index += 1
