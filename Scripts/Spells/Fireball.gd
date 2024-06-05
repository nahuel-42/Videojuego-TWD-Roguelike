class_name Fireball
extends Spell

func _ready():
	super()
	animation.play("firing")

func perform():
	for enemy in enemies_in_range:
		enemy.take_damage(damage)
