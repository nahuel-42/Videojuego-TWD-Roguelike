extends Soldier
class_name EnemyLieutenant

#TODO: CREAR LOS METODOS EN LA CLASE SOLDIER
var allies_in_range = []

func init_stats():
	health = 5
	speed = 75
	super()

func add_ally(body):
	if body.is_in_group(Parameters.GROUPS.SOLDIER) and body not in allies_in_range and body != self:
		allies_in_range.append(body)
		body.boost_speed()

func delete_ally(body):
	if body in allies_in_range and body != self:
		body.decrease_speed()
		allies_in_range.erase(body)
