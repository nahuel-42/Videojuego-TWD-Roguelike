extends CharacterBody2D
class_name Ally

var speed
var acceleration = 5
var target
var health = 5

@onready var animation = $Animation
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var health_bar : ProgressBar = $HealthBar
@onready var sprite : Sprite2D = $Sprite2D

var cooldown = 0.5

func _ready():
	z_index = 3
	target = Parameters.boss_position
	velocity = Vector2.ZERO
	nav.target_position = target.position
	scale /= 2

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
		return
	

func _physics_process(delta):
	move(delta)	

func move(delta):
	var direction = Vector3()
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	
	move_and_slide()

func get_next_waypoint():
	return nav.get_next_path_position()
	
func get_current_waypoint_index():
	return nav.get_current_navigation_path_index()

func reach_target():
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	visible = false
	# TODO: Pelear contra el boss
	return 
		
func take_damage(damage):
	cooldown = 0.5
	health -= damage
	health_bar.value -= damage
	if health > 0:
		return
		
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	visible = false
