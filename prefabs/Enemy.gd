extends CharacterBody2D


var speed = 300
var acceleration = 7
var target

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready():
	get_tree().get_nodes_in_group("target")[0].connect("body_entered", reach_target)
	velocity = Vector2.ZERO
	target = get_parent().get_parent().get_node("Target")
	nav.target_position = target.position
	
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
		queue_free()
		print("Un enemigo ha escapado")
		
func take_damage():
	set_process_mode(Node.ProcessMode.PROCESS_MODE_DISABLED)
	#visible = false
