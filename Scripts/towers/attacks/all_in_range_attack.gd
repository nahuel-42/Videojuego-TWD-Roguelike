class_name AllInRangeAttackMethod
extends AttackMethod

func fire():
	# TODO: Hacer las demás cosas como ver la probabilidad de acierto, animación, etc.
	modulate = Color(1, 0, 0)
	if len(enemies_in_range) != 0:
		cooldown = attack_speed
	for enemy in enemies_in_range:
		speciality.act(enemy, damage)
		
