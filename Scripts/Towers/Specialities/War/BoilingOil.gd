class_name BoilingOil
extends War

func _ready():
	super()
	id = -1
	label.text = "Oil (S)"

func apply_effects(enemy):
	enemy.start_bleeding()
