extends CharacterBody2D
class_name Enemy

var speed
var acceleration = 5
var target
var health
var damage_to_health = 10 #deberian especificarse en cada hijo todos los atributos
var passive_speed_modifier = 1.0

var vulnerable = false
var slowed = false
var stunned = false
var bleeding = false
var bleeding_damage = 0.25

@onready var animation = $Animation
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var health_bar : ProgressBar = $HealthBar
@onready var sprite = $Sprite2D

var cooldown = 0.5

func set_group():
	pass
	
func init_stats():
	health_bar.max_value = health
	health_bar.value = health

func load_stats():
	animation.connect("animation_finished", effect_finished)
	GameController.apply_passives()

func _ready():
	nav.debug_enabled = false
	z_index = 3
	target = Parameters.target
	velocity = Vector2.ZERO
	nav.target_position = target.position
	load_stats()
	add_to_group(Parameters.GROUPS.ENEMY)
	set_group()
	init_stats()
	scale /= 2

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
		return
	

func _physics_process(delta):
	if stunned:
		return
		
	move(delta)	

func move(delta):
	var direction = Vector3()
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	velocity = velocity.lerp(direction * speed * passive_speed_modifier, acceleration * passive_speed_modifier * delta)
	
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
	
	animation.play("Bleed")
	sprite.modulate = Color(1, 0, 0)

func deal_bleeding_damage():
	take_damage(bleeding_damage)

func terminate_bleeding():
	bleeding = false
	sprite.modulate = Color(1, 1, 1)

func start_slow():
	if slowed:
		return
	animation.play("Slow")
	sprite.modulate = Color(0, 0, 1)
	speed /= 2
	slowed = true

func terminate_slow():
	slowed = false
	speed *= 2
	sprite.modulate = Color(1, 1, 1)
	

func start_stun():
	if stunned:
		return
		
	stunned = true
	animation.play("Stun")
	sprite.modulate = Color(0, 1, 0)
	
func terminate_stun():
	stunned = false
	sprite.modulate = Color(1, 1, 1)

func start_vulnerable():
	if vulnerable:
		return
		
	vulnerable = true
	animation.play("Vulnerable")
	sprite.modulate = Color(1, 1, 0)
	#call_deferred("terminate_vulnerable", 5)

func terminate_vulnerable():
	vulnerable = false
	sprite.modulate = Color(1, 1, 1)

func effect_finished(animation_name):
	match animation_name:
		"Slow": terminate_slow()
		"Stun": terminate_stun()
		"Vulnerable": terminate_vulnerable()
		"Bleed": terminate_bleeding()
	
	animation.play("Walk")

func apply_speed_passive(modifier):
	passive_speed_modifier = modifier
