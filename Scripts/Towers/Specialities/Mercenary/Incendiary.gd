class_name Incendiary
extends MercenarySpeciality

func _ready():
	super()
	id = -1
	label.text = "Incendiary (M)"

func apply_effects(enemy):
	enemy.start_bleeding()
