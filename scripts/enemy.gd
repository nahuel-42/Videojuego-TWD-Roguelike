extends CharacterBody2D


var speed = 125
var acceleration = 5
var target
var health = 3
@onready var animation = $Animation
@onready var nav: NavigationAgent2D = $NavigationAgent2D

var cooldown = 0.5

func _ready():
	target = Parameters.target
	target.connect("body_entered", reach_target)
	velocity = Vector2.ZERO
	nav.target_position = target.position
	animation.play("run")

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
		return
	
	modulate = Color(1, 1, 1)

func _physics_process(delta):
	move(delta)
		
	

func move(delta):
	var direction = Vector3()
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	
	move_and_slide()
	
func get_next_waypoint():
	return nav.get_next_path_position()
	
func get_current_waypoint_index():
	return nav.get_current_navigation_path_index()

func reach_target(body):
	if body == self:
		set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
		visible = false
		print("Un enemigo ha escapado")
		
func freeze():
	pass
		
func take_damage(damage):
	cooldown = 0.5
	modulate = Color(1, 0, 0)
	health -= damage
	if health > 0:
		return
		
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	visible = false
