extends Soldier
class_name EnemyLieutenant

#TODO: CREAR LOS METODOS EN LA CLASE SOLDIER
var allies_in_range = []
var boost_speed = 1.1
var decrease_boost = 0.1

func add_ally(body):
	if body.is_in_group("SOLDIER") and body != self:
		allies_in_range.append(body)
		body.boost_speed

func delete_ally(body):
	if body in allies_in_range and body != self:
		body.decrease_speed
		allies_in_range.erase(body)
