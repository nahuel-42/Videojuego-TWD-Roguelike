class_name War
extends Speciality

func _ready():
	label.text = "Soldier"

func modify_damage(enemy, damage):
	if enemy.is_in_group(GROUPS.DRAKE):
		return 0
	
	if enemy.is_in_group(GROUPS.SOLDIER):
		damage *= 2
	return damage
