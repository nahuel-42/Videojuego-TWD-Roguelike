class_name Mercenary
extends Speciality

func modify_damage(enemy, damage):
	if enemy.is_in_group(GROUPS.MERCENARY):
		damage *= 2
	return damage
