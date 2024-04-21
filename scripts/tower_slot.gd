extends "res://scripts/slot.gd"

func _ready():
	tower_point = $TowerPoint

func apply_card(card):
	if child == null:
		# Ver si conviene pasarle a create_tower el prefab y las estadísticas con la torre.
		create_tower(load(card.prefab_path)) # Setear parametros de la torre segun card
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
