class_name OneTargetAttackMethod
extends AttackMethod

var current_target

func fire():
	# TODO: Hacer las demás cosas como ver la probabilidad de acierto, animación, etc.
	if current_target != null and current_target in enemies_in_range:
		modulate = Color(1, 0, 0)
		speciality.act(current_target, damage)
		cooldown = attack_speed
		
	set_new_target()

func set_new_target():
	var first_enemy = null
	var first_enemy_distance_left = INF
	for enemy in enemies_in_range:
		var enemy_distance_left = enemy.position.distance_to(enemy.get_next_waypoint())
		
		if first_enemy != null:
			first_enemy_distance_left = first_enemy.position.distance_to(first_enemy.get_next_waypoint())
		else:
			first_enemy = enemy
			continue 
		
		if enemy.get_current_waypoint_index() > first_enemy.get_current_waypoint_index() or (enemy.get_current_waypoint_index() == first_enemy.get_current_waypoint_index() and enemy_distance_left < first_enemy_distance_left):
			first_enemy = enemy;
	current_target = first_enemy
