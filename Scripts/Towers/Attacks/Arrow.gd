class_name Arrow
extends Area2D

@export var speed := 200.0
@onready var sprite : Sprite2D = $Sprite2D
var target : Enemy
var attack : AttackMethod
var damage : int
@onready var cs : CollisionShape2D = $CollisionShape2D

func _process(delta):
	if target.get_process_mode() != Node.ProcessMode.PROCESS_MODE_DISABLED:
		var direction = (target.global_position - global_position).normalized()
		var movement = direction * speed * delta
		global_position += movement
		
		sprite.rotation = Vector2(1,0).angle_to(direction)
	else:
		cs.disabled = true
		queue_free()

func set_target(target: Enemy):
	self.target = target
	
func set_attack_method(attack: AttackMethod):
	self.attack = attack
	
func set_damage(damage: int):
	self.damage = damage


func _on_body_entered(body):
	if body == target:
		attack.do_damage_to_enemy(target, damage)
		queue_free() 
