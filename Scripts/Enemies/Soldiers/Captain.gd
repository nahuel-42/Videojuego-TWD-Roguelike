extends Soldier
class_name EnemyCaptain

#TODO: solo ser dañado si la torre es de tipo especialista en guerra

func set_group():
	add_to_group(Parameters.GROUPS.CAPTAIN)
