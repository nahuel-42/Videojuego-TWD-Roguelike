extends Area2D
class_name Fireball

var destination : Vector2
var velocity : Vector2
var damage : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	if(position.distance_to(destination) < 10):
		print("BOOM!")
		$CollisionShape2D.set_process(true)	
		velocity = Vector2.ZERO
		queue_free()

func load_stats(animation_destination : Vector2, cell_dimension):
	position = animation_destination - Vector2(cell_dimension, 3 * cell_dimension)
	destination = animation_destination
	velocity = (position + animation_destination).normalized() * 200

func move(delta):
	position += velocity * delta

func perform(body):
	body.take_damage(damage)

func _on_enemy_entered(body):
	perform(body)
