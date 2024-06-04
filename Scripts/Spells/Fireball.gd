extends Area2D
class_name Fireball

var destination : Vector2
var velocity : Vector2
var damage : int = 10
var enemies_in_range = []
@onready var colision_shape : CollisionShape2D = $CollisionShape2D
@onready var animation : AnimationPlayer = $Animation
@onready var sprite : Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("firing")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	if(global_position.distance_to(destination) < 10):
		print("BOOM!")
		velocity = Vector2.ZERO
		perform()
		queue_free()

func load_stats(animation_destination : Vector2, cell_dimension):
	global_position = animation_destination - Vector2(2 * cell_dimension, 5 * cell_dimension)
	destination = animation_destination
	velocity = Vector2(2 * cell_dimension, 5 * cell_dimension).normalized() * 100
	sprite.rotation = Vector2(1,0).angle_to(velocity)
	sprite.flip_h = true

func move(delta):
	global_position += velocity * delta

func perform():
	for enemy in enemies_in_range:
		enemy.take_damage(damage)


# Función para detectar cuando un objeto entra en el área
func add_enemy(body):
	if body != self:  # Agregar que sea del grupo enemy
		enemies_in_range.append(body)

# Función para detectar cuando un objeto sale del área
func delete_enemy(body):
	if body != self and body in enemies_in_range:
		enemies_in_range.erase(body)
