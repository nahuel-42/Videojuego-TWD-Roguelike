extends Tower

func shoot(target):
	# TODO: Hacer las demás cosas como ver la probabilidad de acierto, animación, etc.
	modulate = Color(1, 0, 0)
	for enemy in enemies_in_range:
		enemy.take_damage(get_damage())
		enemy.freeze()
