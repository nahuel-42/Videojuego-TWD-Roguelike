class_name AttackMethod 
extends Node2D

var collision_shape : CollisionShape2D
var enemies_in_range = []
var range: float
var attack_speed = 1
var cooldown = 0

var damage: int
var accuracy: float

func load_stats(stats):
	range = stats["range"] / scale.x
	collision_shape = get_node("../Range/CollisionShape2D")
	collision_shape.shape.radius = range
	attack_speed = stats["attackSpeed"]
	damage = stats["damage"]
	accuracy = stats["accuracy"]
	

func get_damage():
	return damage
	
func get_range():
	return range

func perform(delta):
	if cooldown > 0:
		if cooldown < attack_speed/1.5:
			modulate = Color(1, 1, 1)
		cooldown -= delta
		return
	
	fire()

# Función para detectar cuando un objeto entra en el área
func add_enemy(body):
	if body != self:  # Agregar que sea del grupo enemy
		enemies_in_range.append(body)

# Función para detectar cuando un objeto sale del área
func delete_enemy(body):
	if body != self and body in enemies_in_range:
		enemies_in_range.erase(body)

func fire():
	pass
