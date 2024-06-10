class_name Arrow
extends Area2D

@export var speed := 200.0
@onready var sprite : Sprite2D = $Sprite2D
var target : Enemy
var speciality : Speciality
var damage : int

func _process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		var movement = direction * speed * delta
		global_position += movement
		
		sprite.rotation = Vector2(1,0).angle_to(direction)

func set_target(target: Enemy):
	self.target = target
	
func set_speciality(speciality: Speciality):
	self.speciality = speciality
	
func set_damage(damage: int):
	self.damage = damage


func _on_body_entered(body):
	if body == target:
		speciality.act(target, damage)
		queue_free() 
