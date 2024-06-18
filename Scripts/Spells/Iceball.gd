class_name Iceball
extends Spell

func _ready():
	super()
	animation.play("firing")
	Audio.playSFX("iceballFlying")

func perform():
	Audio.playSFX("iceballExplosion") # TODO: Que se llame sólo una vez
	for enemy in enemies_in_range:
		enemy.start_slow()
