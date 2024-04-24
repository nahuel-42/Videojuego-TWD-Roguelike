extends Slot

const CARDS_PATH = "res://cards/"

func _ready():
	tower_point = $TowerPoint

func apply_card(card):
	match card.type:
		"tower": 
			create_tower(card.id)
		"upgrade":
			upgrade_tower(card.id)
		"delete":
			delete_tower()

func find_card(collection, id):
	var col = GlobalCardsList.CollectionCard[collection]
	for card in col:
		if card["id"] == id:
			return card
	return {}

func create_tower(id):
	var stats = find_card("towers", id)
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
