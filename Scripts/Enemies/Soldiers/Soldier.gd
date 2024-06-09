class_name Soldier
extends Enemy

var is_boosted

func set_group():
	add_to_group(Parameters.GROUPS.SOLDIER)


func heal(healing):
	health += healing
