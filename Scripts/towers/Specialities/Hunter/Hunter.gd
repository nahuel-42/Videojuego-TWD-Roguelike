class_name Hunter
extends Speciality

func modify_damage(enemy, damage):
	if enemy.is_in_group(GROUPS.BEAST):
		damage *= 2
	return damage
