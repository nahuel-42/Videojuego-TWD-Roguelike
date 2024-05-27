extends CharacterBody2D
class_name Enemy

var speed = 125 
var acceleration = 5
var target
var health = 5
var damage_to_health = 1 #deberian especificarse en cada hijo todos los atributos

var vulnerable = false
var slowed = false
var stunned = false
var bleeding = false
var bleeding_damage = 1

@onready var animation = $Animation
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var health_bar : ProgressBar = $HealthBar

var cooldown = 0.5

func set_group():
	pass
	
func init_stats():
	pass

func _ready():
	z_index = 3
	target = Parameters.target
	health_bar.max_value = health
	velocity = Vector2.ZERO
	nav.target_position = target.position
	animation.play("run")
	set_group()
	init_stats()
	scale /= 2

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
		return
	
	modulate = Color(1, 1, 1)

func _physics_process(delta):
	if stunned:
		return
		
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

func reach_target():
	#if body == self:
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	visible = false
	#print("Un enemigo ha escapado")
	return damage_to_health
		
func stun():
	stunned = true
		
func take_damage(damage):
	if vulnerable:
		damage *= 2
	cooldown = 0.5
	modulate = Color(1, 0, 0)
	health -= damage
	health_bar.value -= damage
	if health > 0:
		return
		
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	visible = false

func start_bleeding():
	if bleeding:
		return
		
	bleeding = true
	call_deferred("deal_bleeding_damage", 1)
	call_deferred("terminate_bleeding", 5)

func deal_bleeding_damage():
	print("bleeding")
	take_damage(bleeding_damage)
	if bleeding:
		call_deferred("deal_bleeding_damage", 1)

func terminate_bleeding():
	bleeding = false

func start_slow():
	if slowed:
		return
	
	speed /= 2
	slowed = true
	call_deferred("terminate_slow", 4)

func terminate_slow():
	slowed = false
	speed *= 2

func start_stun():
	if stunned:
		return
		
	stunned = true
	call_deferred("terminate_stun", 2)
	
func terminate_stun():
	stunned = false

func start_vulnerable():
	if vulnerable:
		return
		
	vulnerable = true
	call_deferred("terminate_vulnerable", 5)

func terminate_vulnerable():
	vulnerable = false
