extends Node2D

var range
var fire_rate = 1
var damage

var bullet_prefab
var bullet_speed
var current_target

var enemies_in_range = []

func _ready():
	get_node("Timer").wait_time = fire_rate


func _on_timer_timeout():
	if current_target != null and current_target in enemies_in_range:
		shoot(current_target)
	
	set_new_target()
	
# Función para detectar cuando un objeto entra en el área
func add_enemy(body):
	if body != self:  # Agregar que sea del grupo enemy
		enemies_in_range.append(body)
		print("Objeto entró en la esfera:", body.name)

# Función para detectar cuando un objeto sale del área
func delete_enemy(body):
	if body != self and body in enemies_in_range:
		enemies_in_range.erase(body)
		print("Objeto salió de la esfera:", body.name)

func shoot(target):
	pass
	
# TODO: Arreglar tema waypoints (ver comentarios)
func set_new_target():
	var first_enemy = null
	var first_enemy_distance_left = Mathf.Infinity  # Ver como inicializar en infinito
	for enemy in enemies_in_range:
		var enemy_distance_left = Vector2.Distance(enemy.transform.position, enemy.nextWaypoint.position) # Arreglar esto
		
		if first_enemy != null:
			firstEnemyDistanceLeft = Vector2.Distance(first_enemy.transform.position, first_enemy.nextWaypoint.position) # Arreglar esto
		else:
			first_enemy = enemy
			continue  # Ver si continue funciona como en C#
		
		# Arreglar esto
		if enemy.nextWaypointIndex > first_enemy.nextWaypointIndex or (enemy.nextWaypointIndex == first_enemy.nextWaypointIndex and enemy_distance_left < first_enemy_distance_left):
			first_enemy = enemy;
	
	current_target = first_enemy
