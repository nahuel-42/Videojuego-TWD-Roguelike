extends Camera2D

const camera_speed = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_down"):
		position.y += camera_speed*delta
	elif Input.is_action_pressed("ui_up"):
		position.y -= camera_speed*delta
	elif Input.is_action_pressed("ui_left"):
		position.x -= camera_speed*delta
	elif Input.is_action_pressed("ui_right"):
		position.x += camera_speed*delta
	elif Input.is_action_just_released("wheel_up"):
		zoom *= 1.1
	elif Input.is_action_just_released("wheel_down"):
		zoom *= 0.9
		
		
