extends Mercenary
class_name EnemyEngineer

#TODO: Desactiva torres por cierto tiempo cuando esta al rango de alcance de estas
var towers_in_range = []
var cooldown_disable #agregar un valor

func _process(delta):
	perform(delta)

func perform(delta): #Ver como hacer esto despues
	if cooldown_disable > 0:
		cooldown_disable -= delta
	return

	disable_tower()

func add_tower(body):
	if body.is_in_group("TOWER") and body != self:
		towers_in_range.append(body)

func delete_tower(body):
	if body in towers_in_range and body != self:
		towers_in_range.erase(body)

func disable_tower():
	#if len(towers_in_range) != 0
		
	for tower in towers_in_range:
		tower.disable() # donde habria que pegarle aca?
