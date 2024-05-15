extends Node2D

const ENEMY_PREFAB_PATH = "res://prefabs/enemy.tscn"

var last_enemy_index
var enemies = []
var enemies_node 

func _ready():
	enemies_node = $Enemies
	#load_enemies()

func load_enemies():
	var prefab = load(ENEMY_PREFAB_PATH)
	enemies = []
	last_enemy_index = 0
	for i in range(10):  # Agrega 10 enemigos de ejemplo
		var enemy_instance = prefab.instantiate()
		
		enemies_node.add_child(enemy_instance)
		enemies.append(enemy_instance)
		enemy_instance.set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		enemy_instance.visible = false

func reset_enemies():
	for enemy in enemies:
		if enemy.get_process_mode() != Node.ProcessMode.PROCESS_MODE_DISABLED:
			return
			
	print("Resetting enemies...")
	load_enemies()
	

func _on_timer_timeout():
	if len(enemies) == 0:
		load_enemies()
	
	if last_enemy_index < len(enemies):
		enemies[last_enemy_index].set_process_mode(Node.ProcessMode.PROCESS_MODE_INHERIT)
		enemies[last_enemy_index].visible = true
		last_enemy_index += 1
	else:
		reset_enemies()
