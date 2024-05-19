class_name War
extends Speciality

func modify_damage(enemy, damage):
	if enemy.is_in_group(GROUPS.SOLDIER):
		damage *= 2
	return damage
