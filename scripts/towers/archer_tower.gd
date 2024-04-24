extends Tower

func shoot(target):
	# TODO: Hacer las demás cosas como ver la probabilidad de acierto, animación, etc.
	modulate = Color(1, 0, 0)
	target.take_damage(get_damage())
