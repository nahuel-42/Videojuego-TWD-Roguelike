extends CharacterBody2D

var destination : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_process(false)
	position = - get_viewport_rect().size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()

func load_stats(animation_destination : Vector2):
	destination = animation_destination
	print("voy a arrancar desde ", position)
	print("el destino es ", destination)
	velocity = destination.normalized() * 100
	print("la velocidad es de ", velocity)
