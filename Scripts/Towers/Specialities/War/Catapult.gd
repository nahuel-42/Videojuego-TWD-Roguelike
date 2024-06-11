class_name Catapult
extends War

func _ready():
	super()
	id = -1

func apply_effects(enemy):
	enemy.start_slow()
