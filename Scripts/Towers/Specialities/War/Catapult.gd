class_name Catapult
extends War

func _ready():
	super()
	id = -1
	label.text = "Catapult (S)"

func apply_effects(enemy):
	enemy.start_slow()
