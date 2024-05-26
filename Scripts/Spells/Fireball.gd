extends CharacterBody2D
class_name Fireball

var destination : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_process(false)
	position = - get_viewport_rect().size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()
	print("position: ", position)
	print("destination: ", destination)
	print("distance: ", position.distance_to(destination))
	if(position.distance_to(destination) < 10):
		print("BOOM!")
		$CollisionShape2D.set_process(true)	

func load_stats(animation_destination : Vector2):
	destination = animation_destination - get_viewport_rect().size / 2
	print("voy a arrancar desde ", position)
	print("el destino es ", destination)
	velocity = animation_destination.normalized() * 200
	print("la velocidad es de ", velocity)
