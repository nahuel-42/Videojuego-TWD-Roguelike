class_name Hunter
extends Speciality

func _ready():
	label.text = "Hunter"
	id = 0

func modify_damage(enemy, damage):
	if enemy.is_in_group(Parameters.GROUPS.CAPTAIN):
		return 0
		
	if enemy.is_in_group(Parameters.GROUPS.BEAST):
		damage *= 2
	return damage
