class_name Dynamite
extends Node2D

@export var speed := 250.0
var target : Vector2
var damage : int
var speciality : Speciality
var has_arrived = false

@onready var explosion_anim : AnimationPlayer = $ExplosionAnimation
var explosion_sprite : Sprite2D 
@onready var sprite : Sprite2D = $Sprite2D
@onready var cs : CollisionShape2D = $Area2D/CollisionShape2D

func _ready():
	explosion_sprite = $Sprite2D/Explosion
	explosion_sprite.visible = false
	cs.disabled = true

func _process(delta):
	if has_arrived:
		return
	
	var direction = (target - global_position).normalized()
	var movement = direction * speed * delta
	
	global_position += movement
	
	if global_position.distance_to(target) < 5:
		has_arrived = true
		explode()
		enable_cs()
	
	rotation = direction.angle()

func set_target(target: Vector2):
	self.target = target
	
func set_speciality(speciality: Speciality):
	self.speciality = speciality
	
func set_damage(damage: int):
	self.damage = damage

func explode():
	explosion_sprite.visible = true
	explosion_anim.play("Explosion")

func enable_cs():
	cs.disabled = false
	
func disable_cs():
	cs.disabled = true

func hit_targets(body):
	if body.is_in_group("Enemy"):
		speciality.act(body, damage)
