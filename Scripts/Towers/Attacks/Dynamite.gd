class_name Dynamite
extends Node2D

@export var speed := 250.0
var target : Vector2
var damage : int
var cs : CollisionShape2D

@onready var explosion_anim : AnimationPlayer = $ExplosionAnimation
var explosion_sprite : Sprite2D 
@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	explosion_sprite = $Sprite2D/Explosion
	explosion_sprite.visible = false

func _process(delta):
	if target:
		var direction = (target - global_position).normalized()
		var movement = direction * speed * delta
		
		global_position += movement
		
		if global_position.distance_to(target) < 5:
			explode()
		
		rotation = direction.angle()

func set_target(target: Vector2):
	self.target = target

func set_cs(cs):
	self.cs = cs

func explode():
	explosion_sprite.visible = true
	explosion_anim.play("Explosion")

func disable_cs():
	cs.disabled = true

func enable_cs():
	cs.disabled = false
