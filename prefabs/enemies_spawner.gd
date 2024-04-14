extends PathFollow2D

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
		enemy_instance.set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		add_child(enemy_instance)
		enemies.append(enemy_instance)


func _on_timer_timeout():
	if last_enemy_index < len(enemies):
		enemies[last_enemy_index].set_process_mode(Node.ProcessMode.PROCESS_MODE_INHERIT)
		print("Enemigo " + enemies[last_enemy_index].name + " instanciado en posicion " + str(enemies[last_enemy_index].position.x))
		last_enemy_index += 1
