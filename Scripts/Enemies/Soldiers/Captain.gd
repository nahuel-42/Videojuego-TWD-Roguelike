extends Soldier
class_name EnemyCaptain

#TODO: solo ser dañado si la torre es de tipo especialista en guerra
func init_stats():
	health = 5
	speed = 75
	super()

func set_group():
	add_to_group(Parameters.GROUPS.CAPTAIN)
