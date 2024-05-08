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
		"delete":
			delete_tower()
	return previous_card_id

func create_tower(id):
	var stats = GlobalCardsList.find_card(id)
	var prefab = load(stats["path"])
	child = prefab.instantiate()
	child.load_stats(stats)
	add_child(child)
	child.position = tower_point.position

func upgrade_tower(id):
	var decorator_prefab = load(DAMAGE_DECORATOR)
	var decorator_instance = decorator_prefab.instantiate()
	child.set("inner_tower",decorator_instance) 

func delete_tower():
	pass
