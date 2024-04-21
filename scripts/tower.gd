extends Node2D

var inner_tower : Node2D = null:
	set(value):
		if inner_tower == null:
			#print("seteando inners ", value)
			inner_tower = value
		else:
			inner_tower.inner_tower = value
var range = 150 / scale.x
var collision_shape : CollisionShape2D
var radius : Line2D
var fire_rate = 1
var cooldown = 0

var meta_damage = 1
var damage: int:
	get:
		if inner_tower == null:
			return meta_damage
		else:
			#print("intenado devolver daamge")
			return inner_tower.damage + meta_damage

var bullet_prefab
var bullet_speed
var current_target

var enemies_in_range = []
var animation

func _ready():
	collision_shape = $Range/CollisionShape2D
	collision_shape.shape.radius = range
	animation = $Animation
	animation.play("idle")
	draw_radius()

func _process(delta):
	if cooldown > 0:
		if cooldown < fire_rate/1.5:
			modulate = Color(1, 1, 1)
		cooldown -= delta
		#print("haria un daño de", damage)
		return
	
	
	if current_target != null and current_target in enemies_in_range:
		shoot(current_target)
		cooldown = fire_rate
	
	set_new_target()
	
func draw_radius():
	var circle_points = []
	radius = $Radius
	radius.width = 1
	var segments = 32  # Número de segmentos para aproximar el círculo
	
	for i in range(segments + 1):
		var angle = i * (2 * PI / segments)
		var x = range * cos(angle)
		var y = range * sin(angle)
		circle_points.append(Vector2(x, y))
	
	radius.points = circle_points
	
# Función para detectar cuando un objeto entra en el área
func add_enemy(body):
	if body != self:  # Agregar que sea del grupo enemy
		enemies_in_range.append(body)

# Función para detectar cuando un objeto sale del área
func delete_enemy(body):
	if body != self and body in enemies_in_range:
		enemies_in_range.erase(body)

func shoot(target):
	# TODO: Hacer las demás cosas como ver la probabilidad de acierto, animación, etc.
	modulate = Color(1, 0, 0)
	target.take_damage(damage)
	
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
	
