class_name Iceball
extends Spell

func _ready():
	super()
	animation.play("firing")
	play_sound("iceballFlying")

func perform(): 
	for enemy in enemies_in_range:
		enemy.start_slow()

func explode():
	play_sound("iceballExplosion")
