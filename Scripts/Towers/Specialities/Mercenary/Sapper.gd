class_name Sapper
extends MercenarySpeciality

func _ready():
	super()
	id = -1
	label.text = "Sapper (M)"

func apply_effects(enemy):
	enemy.start_stun()
