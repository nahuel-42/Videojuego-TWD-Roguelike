class_name Tower
extends Node2D

var collision_shape : CollisionShape2D 
@onready var animation = $Animation

var inner_tower : Node2D = null:
	set(value):
		if inner_tower == null:
			inner_tower = value
		else:
			inner_tower.inner_tower = value
var range: float
var radius : Line2D
var attack_speed = 1
var cooldown = 0

var damage: int
var accuracy: float

var bullet_prefab
var bullet_speed
var current_target

var enemies_in_range = []

func load_stats(stats):
	range = stats["range"] / scale.x
	collision_shape = $Range/CollisionShape2D
	collision_shape.shape.radius = range
	attack_speed = stats["attackSpeed"]
	damage = stats["damage"]
	accuracy = stats["accuracy"]
	
func get_damage():
	if inner_tower == null:
		return damage
	else:
		return inner_tower.get_damage() + damage

func _ready():
	animation.play("idle")
	draw_radius()

func _process(delta):
	if cooldown > 0:
		if cooldown < attack_speed/1.5:
			modulate = Color(1, 1, 1)
		cooldown -= delta
		return
	
	if current_target != null and current_target in enemies_in_range:
		shoot(current_target)
		cooldown = attack_speed
	
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
	pass
	
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
	
