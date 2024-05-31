class_name AttackMethod 
extends Node2D

@onready var speciality : Speciality = $"../Speciality"

var collision_shape : CollisionShape2D
var enemies_in_range = []
var range: float
var attack_speed = 1
var cooldown = 0
var damage: int
var accuracy: float

var damage_mod: float = 1
var range_mod: float = 1
var attack_speed_mod: float = 1 
var accuracy_mod: float = 1

func load_stats(stats):
	range = stats["range"] / scale.x
	collision_shape = get_node("../Range/CollisionShape2D")
	collision_shape.shape.radius = range
	attack_speed = stats["attackSpeed"]
	damage = stats["damage"]
	accuracy = stats["accuracy"]

func upgrade(damage, range, attack_speed, accuracy):
	damage_mod += damage
	range_mod += range
	collision_shape.shape.radius = get_range()
	attack_speed_mod += attack_speed
	accuracy_mod += accuracy

func get_damage():
	return damage * damage_mod
	
func get_range():
	return range * range_mod
	
func get_accuracy():
	return accuracy * accuracy_mod
	
func get_attack_speed():
	return attack_speed * attack_speed_mod

@onready var color = get_parent().modulate
func perform(delta):
	if cooldown > 0:
		if cooldown < attack_speed/1.5:
			get_parent().modulate = color
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
	
func set_speciality(speciality):
	self.speciality.queue_free()
	self.speciality = speciality
	print("Nueva especialidad: " + str(self.speciality))