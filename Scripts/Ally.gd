extends CharacterBody2D
class_name Ally

var speed = 75
var acceleration = 5
var boss
var health = 5
var damage = 3

@onready var animation = $Animation
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var health_bar : ProgressBar = $HealthBar
@onready var sprite : Sprite2D = $Sprite2D
var target_reached = false

var cooldown = 0.5

func _ready():
	z_index = 3
	velocity = Vector2.ZERO
	scale /= 2
	set_target_position()
	add_to_group("ALLIES")

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
		return
	

func _physics_process(delta):
	if target_reached:
		return
		
	move(delta)	

func move(delta):
	var direction = Vector3()
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	animation.play("walk")
	
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	
	move_and_slide()

func get_next_waypoint():
	return nav.get_next_path_position()
	
func get_current_waypoint_index():
	return nav.get_current_navigation_path_index()
		
func take_damage(damage):
	cooldown = 0.5
	health -= damage
	health_bar.value -= damage
	if health <= 0:
		set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		visible = false

func set_target_position():
	boss = Parameters.boss
	nav.target_position = boss.position

func attack(body):
	var random = randi() % 2 + 1
	var attack_direction
	if (abs(position.y-body.position.y) <= 30):
		attack_direction = "side"
	elif (position.y > body.position.y):
		attack_direction = "down"
	else:
		attack_direction = "up"
	
	animation.play("attack_"+attack_direction)

func do_damage():
	boss.take_damage(damage)

func _on_boss_detector_body_entered(body):
	if body.is_in_group("BOSS"):
		target_reached = true
		attack(body)
