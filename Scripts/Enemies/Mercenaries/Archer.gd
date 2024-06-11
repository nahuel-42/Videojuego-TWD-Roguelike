class_name EnemyArcher
extends Mercenary
#TODO: puede disparar con rango al castillo aliado poner un colider

@onready var animation_archer = $AnimationArcher

func init_stats():
	health = 2
	speed = 90
	super()
