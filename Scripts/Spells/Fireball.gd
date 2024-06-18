class_name Fireball
extends Spell

func _ready():
	super()
	animation.play("firing")
	Audio.playSFX("fireballFlying")

func perform():
	Audio.playSFX("fireballExplosion") # TODO: Que se llame sólo una vez
	for enemy in enemies_in_range:
		enemy.take_damage(damage)
