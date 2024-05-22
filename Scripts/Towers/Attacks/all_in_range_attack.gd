class_name AllInRangeAttackMethod
extends AttackMethod

func fire():
	# TODO: Hacer las demás cosas como ver la probabilidad de acierto, animación, etc.
	if len(enemies_in_range) != 0:
		get_parent().modulate = Color(1, 0, 0)
		cooldown = 1 / get_attack_speed()
	for enemy in enemies_in_range:
		speciality.act(enemy, get_damage())
		
