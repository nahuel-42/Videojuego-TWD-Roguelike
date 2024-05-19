extends Slot

#const CARDS_PATH = "res://cards/"
var current_card_id = -1

func _ready():
	tower_point = $TowerPoint

# Si existía una torre, devuelve su ID, sino devuelve -1.
func apply_card(card):
	var previous_card_id = current_card_id
	match card.type:
		"tower": 
			create_tower(card.id)
			current_card_id = card.id
		"upgrade":
			upgrade_tower(card.id)
		"class":
			if child != null:
				set_class(card.id)
		"delete":
			delete_tower()
	return previous_card_id

func create_tower(id):
	var stats = GlobalCardsList.find_card(id)
	var prefab = load(stats["path"])
	child = prefab.instantiate()
	add_child(child)
	child.load_stats(stats)
	child.position = tower_point.position

func set_class(id):
	var stats = GlobalCardsList.find_card(id)
	var prefab = load(stats["path"])
	speciality = prefab.instantiate()
	child.set_speciality(speciality, stats["texture"])

# TODO: Al momento de setear la especialidad de tier 2, que permita elegir entre los 3 posibles para esa clase.
# Luego, se deben modificar las stats base (damage, attackSpeed, etc) de la torre sobre la que se aplica la mejora.

func upgrade_tower(id):
	pass

func delete_tower():
	pass
