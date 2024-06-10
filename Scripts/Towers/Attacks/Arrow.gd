class_name Arrow
extends CharacterBody2D

@export var speed := 200.0
var target : Enemy
var speciality : Speciality
var damage : int

func _process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		var movement = direction * speed * delta
		var collision = move_and_collide(movement)
		if collision:
			_on_collision(collision)
		
		rotation = direction.angle()

func set_target(target: Enemy):
	self.target = target
	
func set_speciality(speciality: Speciality):
	self.speciality = speciality
	
func set_damage(damage: int):
	self.damage = damage

func _on_collision(collision):
	var collider = collision.get_collider()
	if collider == target:
		speciality.act(target, damage)
		queue_free() 
