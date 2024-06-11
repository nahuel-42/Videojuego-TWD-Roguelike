class_name Tamer
extends Hunter

func _ready():
	super()
	id = -1
	label.text = "Tamer (H)"

func apply_effects(enemy):
	enemy.start_stun()
