class_name Iceball
extends Spell

func _ready():
	super()
	animation.play("firing")

func perform():
	for enemy in enemies_in_range:
		enemy.start_slow()
