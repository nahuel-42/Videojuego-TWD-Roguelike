class_name OneTargetAttackMethod
extends AttackMethod

var current_target
var ARROW_PREFAB : String = "res://Prefabs/Towers/Arrow.tscn"
@onready var sprite : Sprite2D = $"../Sprite2D"

func fire():
	if current_target != null and current_target in enemies_in_range:
		shoot_arrow()
		cooldown = 1 / get_attack_speed()

func shoot_arrow():
	var arrow : Arrow = load(ARROW_PREFAB).instantiate()
	arrow.set_target(current_target)
	arrow.set_speciality(speciality)
	arrow.set_damage(get_damage())
	add_child(arrow)

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
	update_tower_rotation()

func update_tower_rotation():
	if current_target != null:
		var direction = (current_target.global_position - global_position).normalized()
		rotation = direction.angle()

		# Ajustar flip_h basado en la posición del enemigo
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
