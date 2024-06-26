class_name AttackMethod 
extends Node2D

@onready var speciality : Speciality = $"../Speciality"
@onready var animation : AnimationPlayer = $"../Animation"

var collision_shape : CollisionShape2D
var enemies_in_range = []
var range: float
var attack_speed = 1
var cooldown = 0
var damage: int
var accuracy: float
var audio_player : AudioStreamPlayer
var attack_sound : String

var damage_mod: float = 1
var range_mod: float = 1
var attack_speed_mod: float = 1 
var accuracy_mod: float = 1
var passive_attack_speed_modifier = 1.0

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
	return attack_speed * attack_speed_mod * passive_attack_speed_modifier

func perform(delta):
	if cooldown > 0:
		cooldown -= delta
		return
	
	if len(enemies_in_range) != 0:
		animation.speed_scale = get_attack_speed()
		play_sound(attack_sound)
		animation.play("Attack")

# Función para detectar cuando un objeto entra en el área
func add_enemy(body):
	if body.is_in_group("Enemy"):  # Agregar que sea del grupo enemy
		enemies_in_range.append(body)

# Función para detectar cuando un objeto sale del área
func delete_enemy(body):
	if body.is_in_group("Enemy") and body in enemies_in_range:
		enemies_in_range.erase(body)

func fire():
	pass
	
func set_class(tower_class):
	self.speciality.queue_free()
	self.speciality = tower_class

func set_speciality(speciality):
	self.speciality.queue_free()
	self.speciality = speciality
		
func apply_attack_speed_passive(modifier):
	passive_attack_speed_modifier = modifier

func hits():
	var random = randi() % 100 + 1
	return random <= accuracy * 100

func class_id():
	return speciality.class_id()
	
func do_damage_to_enemy(target, damage):
	speciality.act(target, damage)
	
func set_audio_player(audio_player):
	self.audio_player = audio_player

func play_sound(name):
	if name == "":
		return 
	audio_player.stream = Audio.getSFX(name)
	audio_player.play()
