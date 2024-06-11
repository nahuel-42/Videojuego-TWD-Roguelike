class_name Gas
extends MercenarySpeciality

func _ready():
	super()
	id = -1
	label.text = "Gas (M)"

func apply_effects(enemy):
	enemy.start_vulnerable()
