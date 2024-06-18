class_name Iceball
extends Spell

func _ready():
	super()
	animation.play("firing")
	Audio.playSFX("iceballFlying")

func perform(): 
	for enemy in enemies_in_range:
		enemy.start_slow()

func explode():
	Audio.playSFX("iceballExplosion")
