class_name MercenarySpeciality
extends Speciality

func _ready():
	label.text = "Mercenary"

func modify_damage(enemy, damage):
	if enemy.is_in_group(Parameters.GROUPS.DRAKE) or enemy.is_in_group(Parameters.GROUPS.CAPTAIN):
		return 0 
	
	if enemy.is_in_group(Parameters.GROUPS.MERCENARY):
		damage *= 2
	return damage
