class_name EnemyDrake
extends Beast

#TODO: solo le puede causar daño el tipo de torre cazadores de bestias, en caso contrario evitar damage
#Deberia tener menos vida ya que solo puede ser atacado x una especialidad
@onready var animationDrake = $AnimationDrake


func init_stats():
	health = 5
	speed = 75
	super()

func set_group():
	add_to_group(Parameters.GROUPS.DRAKE)
