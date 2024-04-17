extends "res://scripts/slot.gd"

const TOWER_PREFAB_PATH = "res://prefabs/tower.tscn"

func _ready():
	tower_point = $TowerPoint

func apply_card(card):
	if child == null:
		create_tower(load(TOWER_PREFAB_PATH)) # Setear parametros de la torre segun card
	else:
		if card.type == "upgrade":
			upgrade_tower()
		else:
			delete_tower()

func create_tower(tower_prefab):
	child = tower_prefab.instantiate()
	add_child(child)
	child.position = tower_point.position

func upgrade_tower():
	var decorator_prefab = load(DAMAGE_DECORATOR)
	var decorator_instance = decorator_prefab.instantiate()
	get_child(3).set("inner_tower",decorator_instance) 

func delete_tower():
	pass
