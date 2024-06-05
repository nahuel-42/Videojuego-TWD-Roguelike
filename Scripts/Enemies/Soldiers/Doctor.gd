extends Soldier
class_name EnemyDoctor

#TODO: curar enemigos que estan en rango
var cooldown_heal = 2 # TODO: cambiar esto pq estaria muy roto
var amount_heal = 1
var allies_in_range = []

func perform(delta): #Ver como hacer esto despues
	if cooldown_heal > 0:
		
		return

	healAlly()

func add_ally(body):
	if body.is_in_group("SOLDIER") and body != self:
		allies_in_range.append(body)

func delete_ally(body):
	if body in allies_in_range and body != self:
		allies_in_range.erase(body)

func healAlly():
	if len(allies_in_range) != 0:
		cooldown_heal = 1 #Modificar !!!!
	for ally in allies_in_range:
		ally.heal(amount_heal) #Crear Funcion en enemy que lo permita curarse
		
