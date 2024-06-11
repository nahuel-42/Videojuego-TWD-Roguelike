extends Slot

#const CARDS_PATH = "res://cards/"
var current_card_id = -1
@onready var sprite : Sprite2D = $Area2D/Sprite2D 

func _ready():
	tower_point = $TowerPoint
	z_index = 2

#Aplica el tipo especialidad
#Devuelve la especialidad (Hunter = 0, Soldier = 1, Mercenary = 2)
#Y el subtipo:
#Hunter -> Harpoon = 0, Net = 1, Tamer = 2
#Soldier -> Boiling = 0, Catapult = 1, Sniper = 2
#Mercenary -> Sapper = 0, Gas = 1, Incendiary = 2
func apply_speciality(speciality_id):
	var speciality
	var path
	# TODO: Crear los prefabs y poner sus rutas
	match child.class_id():
		0: match speciality_id:
			0: path = "res://Prefabs/Specialities/Harpoon.tscn"
			1: path = "res://Prefabs/Specialities/Net.tscn"
			2: path = "res://Prefabs/Specialities/Tamer.tscn"
		1: match speciality_id:
			0: path = "res://Prefabs/Specialities/BoilingOil.tscn"
			1: path = "res://Prefabs/Specialities/Catapult.tscn"
			2: path = "res://Prefabs/Specialities/Sniper.tscn"
		2: match speciality_id:
			0: path = "res://Prefabs/Specialities/Sapper.tscn"
			1: path = "res://Prefabs/Specialities/Gas.tscn"
			2: path = "res://Prefabs/Specialities/Incendiary.tscn"
	speciality = load(path).instantiate()
	child.set_speciality(speciality)
	
# Si existía una torre, devuelve su ID, sino devuelve -1.
func apply_card(card):
	var previous_card_id = current_card_id
	match card.type:
		"tower":
			if current_card_id != -1:
				delete_tower()
			create_tower(card.id)
			current_card_id = card.id
			sprite.visible = false
		"upgrade":
			if child != null:
				upgrade_tower(card.id)
		"class":
			if child != null and !child.has_class():
				set_class(card.id)
			else:
				return -1
		"delete":
			delete_tower()
			current_card_id = -1
		"speciality":
			return child != null and child.has_class() if child.class_id() else -1
			
	return previous_card_id

func create_tower(id):
	var stats = GlobalCardsList.find_card(id)
	var prefab = load(stats["path"])
	child = prefab.instantiate()
	add_child(child)
	child.add_to_group(Parameters.GROUPS.TOWER)
	child.load_stats(stats)
	child.position = tower_point.position
	GameController.apply_passives()

func set_class(id):
	var stats = GlobalCardsList.find_card(id)
	var prefab = load(stats["path"])
	tower_class = prefab.instantiate()
	child.set_class(tower_class)

# TODO: Al momento de setear la especialidad de tier 2, que permita elegir entre los 3 posibles para esa clase.
# Luego, se deben modificar las stats base (damage, attackSpeed, etc) de la torre sobre la que se aplica la mejora.

func upgrade_tower(id):
	var stats = GlobalCardsList.find_card(id)
	child.upgrade(stats["damage"], stats["range"], stats["attack_speed"], stats["accuracy"])

func delete_tower():
	child.queue_free()
