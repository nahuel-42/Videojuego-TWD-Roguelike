extends Node2D

var range
var fire_rate = 1
var cooldown = 0
var damage

var bullet_prefab
var bullet_speed
var current_target

var enemies_in_range = []

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
		return
	
	
	if current_target != null and current_target in enemies_in_range:
		shoot(current_target)
		cooldown = fire_rate
	
	set_new_target()
	
# Función para detectar cuando un objeto entra en el área
func add_enemy(body):
	if body != self:  # Agregar que sea del grupo enemy
		enemies_in_range.append(body)

# Función para detectar cuando un objeto sale del área
func delete_enemy(body):
	if body != self and body in enemies_in_range:
		enemies_in_range.erase(body)

func shoot(target):
	# TODO: Hacer las demás cosas como ver la probabilidad de acierto, etc.
	target.take_damage()
	
func set_new_target():
	var first_enemy = null
	var first_enemy_distance_left = INF
	for enemy in enemies_in_range:
		var enemy_distance_left = enemy.position.distance_to(enemy.get_next_waypoint())
		
		if first_enemy != null:
			first_enemy_distance_left = first_enemy.position.distance_to(first_enemy.get_next_waypoint())
		else:
			first_enemy = enemy
			continue  # Ver si continue funciona como en C#
		
		# Arreglar esto
		if enemy.get_current_waypoint_index() > first_enemy.get_current_waypoint_index() or (enemy.get_current_waypoint_index() == first_enemy.get_current_waypoint_index() and enemy_distance_left < first_enemy_distance_left):
			first_enemy = enemy;
	current_target = first_enemy
