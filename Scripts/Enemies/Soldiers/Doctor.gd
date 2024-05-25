extends Soldier
class_name EnemyDoctor

#TODO: curar enemigos que estan en rango
var healing_speed = 2 # TODO: cambiar esto pq estaria muy roto
var amount_heal = 1
var allies_in_range = []

@onready var animation_doctor = $AnimationDoctor

func add_ally(body):
	if body.is_in_group("SOLDIER") and body != self:
		allies_in_range.append(body)

func delete_ally(body):
	if body in allies_in_range and body != self:
		allies_in_range.erase(body)

func heal():
	pass
