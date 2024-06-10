extends Soldier
class_name EnemyDoctor

#TODO: curar enemigos que estan en rango
var cooldown_heal = 2 # TODO: cambiar esto pq estaria muy roto
var cooldown_status = 0
var healing = 1
var allies_in_range = []

#sobreescribo funcion process
func _process(delta):
	perform(delta)

func perform(delta): #Ver como hacer esto despues
	if cooldown_heal > 0:
		cooldown_heal -= delta
		return
	
	cooldown_status = cooldown_heal
	healAlly()

func add_ally(body):
	if body.is_in_group(Parameters.GROUPS.SOLDIER) and body != self:
		allies_in_range.append(body)

func delete_ally(body):
	if body in allies_in_range and body != self:
		allies_in_range.erase(body)

func healAlly():
	for ally in allies_in_range:
		ally.heal(healing)
