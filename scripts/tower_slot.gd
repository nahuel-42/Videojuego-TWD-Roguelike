extends "res://scripts/slot.gd"

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

func load_card(id):
	var file = FileAccess.open(CARDS_PATH + id + ".json", FileAccess.READ)
	var content = file.get_as_text()
	return JSON.parse_string(content)

func create_tower(id):
	var json = load_card(id)
	var prefab = load(json["prefab"])
	child = prefab.instantiate()
	add_child(child)
	child.position = tower_point.position

func upgrade_tower(id):
	var decorator_prefab = load(DAMAGE_DECORATOR)
	var decorator_instance = decorator_prefab.instantiate()
	get_child(3).set("inner_tower",decorator_instance) 

func delete_tower():
	pass
