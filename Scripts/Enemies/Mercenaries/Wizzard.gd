extends Mercenary
class_name EnemyWizzard

#TODO: bajar la cadencia de disparo de torres cercanas
var towers_in_range = []
var slow_attack = 0.2

func add_tower(body):
	if body.is_in_group("TOWER") and body != self: #capaz que la parte de slowed deberia estar aca, consultar esto
		towers_in_range.append(body)
		if !body.slowed: #agregar atributo en tower para que se clave un slowed
			body.slowed = true
			body.AttackMethod.attack_speed -= (body.AttackMethod.attack_speed * slow_attack)

func delete_tower(body):
	if body in towers_in_range and body != self:
		towers_in_range.erase(body)

func slow_attack_speed():
	pass
